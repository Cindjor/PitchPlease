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
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordLabel.hidden = true
        recordButton.enabled = true
        infoLabel.hidden = false
        
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
       
        let recordingName = "my_audio.wav"
        let filePath = documentsURL.URLByAppendingPathComponent(recordingName)
        print(filePath)
        print("trying to record")
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {

        }
        try! session.setActive(true)
        
        audioRecorder = try? AVAudioRecorder(URL: filePath, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true;
        audioRecorder.prepareToRecord()
        audioRecorder.record()

        print("recording audio")
        recordLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        infoLabel.hidden = true
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
        
    }
    
   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if "stopRecording" == segue.identifier {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopRecord(sender: UIButton) {
        recordButton.enabled = true
        recordLabel.hidden = true
        infoLabel.hidden = false
        stopButton.hidden = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }


}

