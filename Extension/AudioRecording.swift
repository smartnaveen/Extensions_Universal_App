//
//  ViewController.swift
//  Demo
//
//  Created by Naveen Kumar on 31/10/23.
//

import UIKit
import AVFoundation

class AudioRecording: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioRecorder()
    }
    
    // Set up audio recording
    func setupAudioRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            try audioSession.setActive(true)
            let audioSettings = [AVFormatIDKey: kAudioFormatMPEG4AAC,
                               AVSampleRateKey: 44100.0,
                         AVNumberOfChannelsKey: 2,
                      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue] as [String : Any]
            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: audioSettings)
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
        } catch {
            print("Error setting up audio recording: \(error.localizedDescription)")
        }
    }
    
    // Start recording
    func startRecording() {
        audioRecorder.record()
        if audioRecorder.isRecording {
            print("Audio recorder is recording")
        } else {
            print("Audio recorder is not recording")
        }
    }
    
    // Stop recording
    func stopRecording() {
        audioRecorder.stop()
    }
    
    // AVAudioRecorder delegate method - called when a recording is finished
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Recording was successful")
            playRecordedAudioFromUserDefaults()
        } else {
            print("Recording failed")
        }
    }
    
    // AVAudioRecorder delegate method - called when a recording is about to finish due to reaching its time limit
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        if let error = error {
            print("Audio recording error: \(error.localizedDescription)")
        }
    }
    
    // AVAudioRecorder delegate method - called when the recorder is about to start recording
    func audioRecorderDidBeginRecording(_ recorder: AVAudioRecorder) {
        print("Recording started")
    }
    
    // AVAudioRecorder delegate method - called repeatedly during recording to give updates about the recording levels
    func audioRecorderUpdateMeters(_ recorder: AVAudioRecorder) {
        // You can use this method to monitor the recording levels
        let averagePower = recorder.averagePower(forChannel: 0)
        let peakPower = recorder.peakPower(forChannel: 0)
        print("Average power: \(averagePower), Peak power: \(peakPower)")
    }
    
    // Get documents directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    @IBAction func btnAction(_ sender: Any) {
        startRecording()
    }
    
    @IBAction func btnplay(_ sender: Any) {
        stopRecording()
    }
    
    func playRecordedAudioFromUserDefaults() {
        let path = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        verifyAudioFile(atPath: path.path, urlPath: path)
    }
    
    func verifyAudioFile(atPath filePath: String, urlPath: URL) {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: filePath)
            if let fileSize = fileAttributes[.size] as? Int {
                print("File size in bytes: \(fileSize)")
            }
        } catch {
            print("Error getting file size: \(error.localizedDescription)")
        }
        
        guard let audioFile = try? AVAudioFile(forReading: URL(fileURLWithPath: filePath)) else {
            print("File is not a valid audio file.")
            return
        }
        let audioFormat = audioFile.fileFormat
        let processingFormat = audioFile.processingFormat
        let frameLength = audioFile.length
        print("File format: \(audioFormat)")
        print("Processing format: \(processingFormat)")
        print("Frame length: \(frameLength)")
        
        do {
            let audioData = try Data(contentsOf: urlPath)
            do {
                audioPlayer = try AVAudioPlayer(data: audioData)
                let session = AVAudioSession.sharedInstance()
                try session.overrideOutputAudioPort(.speaker)
                audioPlayer.prepareToPlay()
                audioPlayer.volume = 1.0
                audioPlayer.play()
            } catch {
                print("Error playing recorded audio from UserDefaults: \(error.localizedDescription)")
            }
            
        } catch {
            print("Error saving recorded audio to UserDefaults: \(error.localizedDescription)")
        }
        
        
    }
}

