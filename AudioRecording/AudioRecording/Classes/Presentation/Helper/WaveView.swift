//
//  WaveView.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

@IBDesignable class WaveView: UIView {
    var phase: CGFloat = 0
    @IBInspectable var amplitude: CGFloat = 1
    @IBInspectable var numberOfWaves:Int = 5
    @IBInspectable var waveColor: UIColor = .white
    @IBInspectable var primaryWaveLineWidth: CGFloat = 5
    @IBInspectable var secondaryWaveLineWidth: CGFloat = 1
    @IBInspectable var idleAmplitude: CGFloat = 0.01
    @IBInspectable var frequency: CGFloat = 1.5
    @IBInspectable var density: CGFloat = 5
    @IBInspectable var phaseShift: CGFloat = -0.15
    
    func updateWithLevel(_ level: CGFloat) {
        self.phase += self.phaseShift
        self.amplitude = fmax(level, self.idleAmplitude)
        
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(self.bounds)
            self.backgroundColor?.set()
            context.fill(rect)
            
            for i in 0...self.numberOfWaves {
                let strokeLineWidth = i == 0 ? self.primaryWaveLineWidth : self.secondaryWaveLineWidth
                context.setLineWidth(strokeLineWidth)
                
                let halfHeight = self.bounds.height / 2
                let width = self.bounds.width
                let mid = width / 2
                
                let maxAmplitude = halfHeight - strokeLineWidth*2
                
                let progress:CGFloat = CGFloat(1 - i / self.numberOfWaves)
                let normedAmplitude = (1.5 * progress - CGFloat(2 / self.numberOfWaves)) * self.amplitude
                
                let multiplier = min(1, (progress / 3*2) + (1/3))
                self.waveColor.withAlphaComponent(multiplier*self.waveColor.cgColor.alpha).set()
                for x in stride(from: 0, to: width+self.density, by: self.density) {
                    //We use a parable to scale the sinus wave, that has it's peak in the middle of the view.
                    let scaling = 1 - pow(1/mid*(x-mid), 2)
                    let y = scaling * maxAmplitude * normedAmplitude * CGFloat(sinf(Float(2 * .pi * x/width * self.frequency + self.phase))) + halfHeight
                    
                    if(x==0) {
                        context.move(to: CGPoint(x: x, y: y))
                    } else {
                        context.addLine(to: CGPoint(x: x, y: y))
                    }
                }
                
                context.strokePath()
            }
        }
    }
}
