//
//  RecordSoundViewController.swift
//  PitchPlease
//
//  Created by Luke Cheung on 1/21/16.
//  Copyright © 2016 Luke Cheung. All rights reserved.
//


import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!

    override func viewDidLoad() {
        stopButton.hidden = true
        recordLabel.hidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        stopButton.hidden = true
    }
    
    
    @IBAction func recordAudio(sender: UIButton) {
        //TODO: record user's voice
        // init
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true)[0] as String
        //save as the same name to not worry about CRUD operations
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath,  recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        print("trying to record")
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        //audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        print("recording audio")
        recordLabel.hidden = !recordLabel.hidden
        stopButton.hidden = false
        recordButton.enabled = false
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            
            recordedAudio = RecordedAudio()
            recordedAudio.filePathURL = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            print("currently recording")
        } else {
            print("recording was unsuccessful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
        
        //TODO: step 2 - play and alter the audio in the next segue
    }
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.recievedAudio = data
        }
    }
    
    @IBAction func stopRecord(sender: UIButton) {
        recordButton.enabled = true
        recordLabel.hidden = true
        stopButton.hidden = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance();
        try! audioSession.setActive(false)
    }


}

