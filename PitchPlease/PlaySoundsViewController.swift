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
//        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            let filePathUrl = NSURL.fileURLWithPath(filePath)
//            
//            
//        } else {
//            print("the filePath is empty")
//        }
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
        audioPlayer.rate = 2.3
        audioPlayer.play()
    }
    @IBAction func slowSoundPlayback(sender: AnyObject) {
        //play audio slowly
        audioPlayer.stop()
        audioPlayer.rate = 0.62
        audioPlayer.play()
    }
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    @IBAction func playVaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-900)
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
