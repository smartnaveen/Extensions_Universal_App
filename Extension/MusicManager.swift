//
//  MusicManager.swift
//  zvoid
//
//  Created by Naveen Kumar on 11/01/23.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import MediaPlayer

protocol MusicManagerDelegate {
    func nextMusic()
    func previousMusic()
    func updateMiniPlayerUI(value: Int, imgUrl: String, title: String, description: String)
    func updateTime(_ seconds: Int64)
}

class MusicManager: NSObject {
    
    static let shared = MusicManager()
    
    var delegatePlay: MusicManagerDelegate?
    
    var avPlayer = AVPlayer()
    var timer: Timer?
    var seconds: Int64 = 0
    var imgUrl = ""
    var title = ""
    var miniDescription = ""
    var nowPlayingInfo = [String : Any]()

    
    // MARK: - Player
    func playerSetup(audioUrl: String, imgUrl: String? = nil, title: String? = nil, miniDescription: String? = nil) {
        self.play(url: URL(string: audioUrl)!)
        self.setupTimer()
        self.imgUrl = imgUrl ?? ""
        self.title = title ?? ""
        self.miniDescription = miniDescription ?? ""
        DispatchQueue.main.async {
            self.getArtBoard(url: self.imgUrl)
        }
    }
    
    func play(url: URL) {
        self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        self.avPlayer.automaticallyWaitsToMinimizeStalling = false
        avPlayer.volume = 1.0
        avPlayer.play()
    }
    
    // Setup Timer
    func setupTimer(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPlayToEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        timer = Timer(timeInterval: 0.001, target: self, selector: #selector(MusicManager.tick), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc func tick(){
        self.showLoader()
    }
    
    @objc func didPlayToEnd() {
        self.delegatePlay?.nextMusic()
    }
    
    // MARK: - Loader
    func showLoader(){
        guard let value = avPlayer.currentItem?.status.rawValue else{return}
        if(value == 0){
            self.delegatePlay?.updateMiniPlayerUI(value: 0, imgUrl: imgUrl, title: title, description: miniDescription)
        }else{
            self.delegatePlay?.updateMiniPlayerUI(value: 1, imgUrl: imgUrl, title: title, description: miniDescription)
            
            if((avPlayer.currentItem?.asset.duration) != nil){
                let seconds: Int64 = Int64(CMTimeGetSeconds((self.avPlayer.currentItem?.currentTime())!))
                self.seconds = seconds
                self.delegatePlay?.updateTime(seconds)
                                
            }else{
                debugPrint("Error")
            }
            
            
        }
    }
    
    func removeObserver()  {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Playing Song in Background
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            if avPlayer.rate == 0.0 {
                avPlayer.play()
                MPNowPlayingInfoCenter.default().nowPlayingInfo![MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds(avPlayer.currentTime())
                MPNowPlayingInfoCenter.default().nowPlayingInfo![MPNowPlayingInfoPropertyPlaybackRate] = 1

                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if avPlayer.rate == 1.0 {
                avPlayer.pause()
                MPNowPlayingInfoCenter.default().nowPlayingInfo![MPNowPlayingInfoPropertyPlaybackRate] = 0
                MPNowPlayingInfoCenter.default().nowPlayingInfo![MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds(avPlayer.currentTime())

                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Next Command
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            self.delegatePlay?.nextMusic()
            return .success
        }
        
        // Add handler for Previous Command
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            self.delegatePlay?.previousMusic()
            return .success
        }
    }
    
    func setupNowPlayingInfo(with artwork: MPMediaItemArtwork) {
        nowPlayingInfo[MPMediaItemPropertyTitle] = "\(title)"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "\(miniDescription)"
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = avPlayer.currentItem?.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = avPlayer.rate
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = avPlayer.currentTime().seconds

        nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    
    func getArtBoard(url: String) {
        guard let url = URL(string: "\(url)") else { return }
        getData(from: url) { [weak self] image in
            guard let self = self,
                  let downloadedImage = image else {
                return
            }
            let artwork = MPMediaItemArtwork.init(boundsSize: downloadedImage.size, requestHandler: { _ -> UIImage in
                return downloadedImage
            })
            self.setupNowPlayingInfo(with: artwork)
        }
    }
    
    func getData(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if let data = data {
                completion(UIImage(data:data))
            }
        }).resume()
    }
}

/*
 // Stop Music
 MusicManager.shared.avPlayer.pause()
 MusicManager.shared.timer?.invalidate()
 
 
 // Play Music
 @IBAction func btnPlayAction(_ sender: Any) {
     MusicManager.shared.removeObserver()
     MusicManager.shared.delegatePlay = self
     MusicManager.shared.playerSetup(audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")
 }
 
 //Delegate
 func nextMusic() {
     print(#function)
 }
 
 func previousMusic() {
     print(#function)
 }
 
 func updateMiniPlayerUI(value: Int, imgUrl: String, title: String, description: String) {
         self.imgMusic.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "thumbnail_1"))
         self.lblTitle.text = title
         self.lblDescription.text = description
         
         if value == 0 { // not playing
         
         }else { // playing
 
            }
 }
 
 func updateTime(_ seconds: Int64) {
     debugPrint("MusicListVC \(seconds)")
 }
 
 // Play/Pause
 if MusicManager.shared.avPlayer.timeControlStatus == .playing  {
     MusicManager.shared.avPlayer.pause()
 }else {
     MusicManager.shared.avPlayer.play()
 }
 
 override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     MusicManager.shared.delegatePlay = self
 }
 
 // Saving Song in recentplay by user default
 func saveMusicInRecentPlay() {
     do {
         let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: self.recentMusicArray, requiringSecureCoding: false)
         self.userDefaults.set(encodedData, forKey: Constant.Variables.kMusic)
         self.userDefaults.synchronize()
     } catch  {
         print("error")
     }
     self.tableView.reloadData()
 }
 */
