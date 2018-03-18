//
//  FilesViewController+BubbleAnimationDelegate.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 18.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import BubbleTransition

extension FilesViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint(x: bottomView.center.x, y: bottomView.center.y + statusBarHeight() + navBarHeight())
        transition.bubbleColor = .lightGray
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: bottomView.center.x, y: bottomView.center.y + statusBarHeight() + navBarHeight())
        transition.bubbleColor = .lightGray
        return transition
    }
    
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return min(statusBarSize.width, statusBarSize.height)
    }
    
    func navBarHeight() -> CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0
    }
}
