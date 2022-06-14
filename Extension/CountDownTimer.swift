//
//  CountDownTimer.swift
//  Extension
//
//  Created by Naveen Kumar on 03/08/21.
//

import Foundation
import UIKit

/*
 var timer: Timer?
 var totalTime = 300
 
 
 override func viewDidLoad() {
     super.viewDidLoad()
 startOtpTimer()
 }
 
 override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(true)
     timer?.invalidate()
 }

 
 private func startOtpTimer() {
     self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
 }
 
 @objc func updateTimer() {
            print(self.totalTime)
            self.lbl.text = self.timeFormatted(self.totalTime) // will show timer
            if totalTime != 0 {
                totalTime -= 1  // decrease counter timer
            } else {
                if let timer = self.timer {
                    timer.invalidate()
                    self.timer = nil
                }
            }
        }
 
 func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
 
 */

