//
//  FilesViewController.swift
//  AudioRecording
//
//  Created by Кирилл Володин on 09.03.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import BubbleTransition

final class FilesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    private var rootAssembly: RootAssembly
    private var model: FilesPresentationModel
    private let cellIdentifier = "\(AudioRecordCell.self)"
    private let cellHeight: CGFloat = 60
    
    init(rootAssembly: RootAssembly, model: FilesPresentationModel) {
        self.model = model
        self.rootAssembly = rootAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Аудиозаписи"
        setupTableView()
        setupMicrophoneButton()
        
        bottomView.layer.masksToBounds = false
        bottomView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 0, height: -2.5)
        bottomView.layer.shadowOpacity = 0.3
        bottomView.layer.shadowRadius = 2
        
        microphoneButton.layer.masksToBounds = false
        microphoneButton.layer.shadowColor = UIColor.red.cgColor
        microphoneButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        microphoneButton.layer.shadowOpacity = 0.5
        microphoneButton.layer.shadowRadius = 4
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupMicrophoneButton() {
        
    }
    
    let transition = BubbleTransition()
    
    @IBAction func record(_ sender: UIButton) {
        let stb = UIStoryboard(name: "Storyboard", bundle: nil)
        guard let viewcontroller = stb.instantiateInitialViewController() else { return }
        viewcontroller.transitioningDelegate = self
        viewcontroller.modalPresentationStyle = .custom
        present(viewcontroller, animated: true, completion: nil)
    }
    
}

extension FilesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AudioRecordCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

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
        return navigationController!.navigationBar.frame.height
    }
    
}
