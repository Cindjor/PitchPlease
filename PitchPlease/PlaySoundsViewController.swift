//
//  PlaySoundsViewController.swift
//  PitchPlease
//
//  Created by Luke CHEUNG on 1/22/16.
//  Copyright © 2016 Luke Cheung. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL)
        
        
    }
    
    @IBAction func stopSound(sender: AnyObject) {
        audioPlayer.stop()
    }
    @IBAction func fastSound(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.rate = 3.3
        audioPlayer.play()
        playAudioWithVariablePitch(0)
    }
    @IBAction func slowSoundPlayback(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.rate = 0.52
        audioPlayer.play()
        playAudioWithVariablePitch(0)
    }
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(900)
    }
    @IBAction func playVaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-800)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
                
        
    }
    
}
