//
//  RecordingViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 10.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import AVFoundation
import SCSiriWaveformView

final class RecordingViewController: UIViewController {

    @IBOutlet weak var waveformView: SCSiriWaveformView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var splashView: UIView!
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var recorder: AVAudioRecorder!
    var seconds: Int = 0
    var timer = Timer()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        waveformView.waveColor = UIColor.red
        waveformView.backgroundColor = .white
        waveformView.primaryWaveLineWidth = 3.0
        waveformView.secondaryWaveLineWidth = 1.0
        self.view.addSubview(waveformView)
        
        let url: URL = URL(fileURLWithPath: "/dev/null")
        let settings: [String : Any] = [
            AVSampleRateKey: 44100.0,
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        do {
            recorder = try AVAudioRecorder(url: url, settings: settings)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            return
        }
        
        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        recorder.record()
        
        let displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector(updateMeters))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runTimer()
    }
    
    private func runTimer() {
        timerLabel.text = timeString(time: TimeInterval(seconds))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    @objc func updateTimer() {
        seconds += 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    private func setupUI() {
        splashView.backgroundColor = .ccRed
        topView.backgroundColor = .ccRed
    }
    
    @objc func updateMeters() {
        recorder.updateMeters()
        let normalizedValue: CGFloat = pow(10, CGFloat(recorder.averagePower(forChannel: 0))/20) + 0.05
        waveformView.update(withLevel: normalizedValue)
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        timer.invalidate()
        animateViews()
    }
    
    func animateViews() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: pauseButton, duration: 0.5, options: transitionOptions, animations: {
            self.pauseButton.isHidden = true
        })
        
        UIView.transition(with: confirmButton, duration: 0.5, options: transitionOptions, animations: {
            self.confirmButton.isHidden = false
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.waveformView.alpha = 0.0
        })
        
        playButton.isEnabled = true
        deleteButton.isEnabled = true
        UIView.animate(withDuration: 0.5) {
            self.playButton.alpha = 1.0
            self.deleteButton.alpha = 1.0
        }
    }
    
}
