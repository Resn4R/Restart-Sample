//
//  AudioPlayer.swift
//  Restart
//
//  Created by Vito Borghi on 27/12/2023.
//

import Foundation
import AVFoundation

var audioplayer: AVAudioPlayer?

func playSound(_ sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioplayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioplayer?.play()
        } catch {
            print("Error while playing sound file")
        }
    }
}
