//
//  ViewController.swift
//  sampleRecorder
//
//  Created by Eriko Ichinohe on 2016/05/26.
//  Copyright © 2016年 Eriko Ichinohe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let fileManager = NSFileManager()
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let fileName = "sample.caf"

    @IBOutlet weak var btnRecord: UIButton!
    
    @IBOutlet weak var btnPlay: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudioRecorder()
    }
    
    @IBAction func tapBtnRecord(sender: UIButton) {
        audioRecorder?.record()
    }
    
    @IBAction func tapBtnPlay(sender: UIButton) {
        play()
    }
    
    // 録音するために必要な設定を行う
    // viewDidLoad時に行う
    func setupAudioRecorder(){
        // 再生と録音機能をアクティブにする
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! session.setActive(true)
        let recordSetting : [String : AnyObject] = [AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey : 16,
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey : 44100.0
        ]
        
        do{
            try audioRecorder = AVAudioRecorder(URL: self.documentFilePath(), settings: recordSetting)
        }catch{
            print("初期設定でのエラー")
        }
    }
    
    // 再生
    func play(){
        do{
            try audioPlayer = AVAudioPlayer(contentsOfURL: self.documentFilePath())
        }catch{
            print("再生時にエラー")
        }
        audioPlayer?.play()
    
    }
    
    // 録音するファイルのパスを取得（録音時、再生時に参照）
    // swift2からstringByAppendingComponent
    func documentFilePath()->NSURL {
        let urls = fileManager.URLsForDirectory(.DocumentationDirectory, inDomains: .UserDomainMask) as [NSURL]

        let dirURL = urls[0]
        
        return dirURL.URLByAppendingPathComponent(fileName)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

