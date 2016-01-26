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
    var recievedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            let filePathUrl = NSURL.fileURLWithPath(filePath)
            audioPlayer = try! AVAudioPlayer(contentsOfURL: filePathUrl)
            audioPlayer.enableRate = true
            
        } else {
            print("the filePath is empty")
        }
    }
    
    @IBAction func stopSound(sender: AnyObject) {
        audioPlayer.stop()
    }
    @IBAction func fastSound(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.rate = 3.9
        audioPlayer.play()
    }
    @IBAction func slowSoundPlayback(sender: AnyObject) {
        //play audio slowly
        audioPlayer.stop()
        audioPlayer.rate = 0.32
        audioPlayer.play()
    }
    
}
