//
//  RecordingViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 10.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
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
    
    var rootAssembly: RootAssembly!
    var model: RecordingPresentationModel!
    
    var seconds: Int = 0
    var timer = Timer()

    init(rootAssembly: RootAssembly, model: RecordingPresentationModel) {
        self.model = model
        self.rootAssembly = rootAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runTimer()
        model.startRecording()
    }
    
    private func setupUI() {
        splashView.backgroundColor = .ccBlue
        topView.backgroundColor = .ccBlue
        
        waveformView.waveColor = .ccBlue
        waveformView.backgroundColor = .white
        waveformView.primaryWaveLineWidth = 3.0
        waveformView.secondaryWaveLineWidth = 1.0
        self.view.addSubview(waveformView)
    }
    
    private func runTimer() {
        timerLabel.text = TimeInterval(seconds).timeString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds += 1
        timerLabel.text = TimeInterval(seconds).timeString()
    }
    
    func updateWaveView(normalizedValue: CGFloat) {
        waveformView.update(withLevel: normalizedValue)
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        model.deleteRecord()
        timer.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        model.stopRecording()
        timer.invalidate()
        animateViews()
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        model.playOrPause(sender)
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        model.deleteRecord()
        seconds = 0
        timerLabel.text = TimeInterval(seconds).timeString()
        model.startRecording()
        runTimer()
        animateViewsForRecording()
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
    
    func animateViewsForRecording() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: pauseButton, duration: 0.5, options: transitionOptions, animations: {
            self.pauseButton.isHidden = false
        })
        
        UIView.transition(with: confirmButton, duration: 0.5, options: transitionOptions, animations: {
            self.confirmButton.isHidden = true
        })
        
        UIView.animate(withDuration: 0.5, animations: {
            self.waveformView.alpha = 1.0
        })
        
        playButton.isEnabled = false
        deleteButton.isEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.playButton.alpha = 0.0
            self.deleteButton.alpha = 0.0
        }
    }
    
    @IBAction func confirmTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension RecordingViewController: RecordingPresentationModelDelegate {
    
    func playingFinished() {
        playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
    }
    
    func updateMeters(_ normalizeValue: CGFloat) {
        waveformView.update(withLevel: normalizeValue)
    }
}
