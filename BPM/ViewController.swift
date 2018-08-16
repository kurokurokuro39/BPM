//
//  ViewController.swift
//  BPM
//
//  Created by kaneko on 2018/08/15.
//  Copyright © 2018年 kaneko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var bpmLabel: UILabel! {
        didSet {
            bpmLabel.text = "0"
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var recently: Date?
    private var intervalArray: [TimeInterval] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        heightConstraint.constant = view.frame.height / 2.0
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "BPM"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.black
        setNeedsStatusBarAppearanceUpdate()
    }

    @IBAction func didTapButton(_ sender: Any) {
        let now = Date()
        guard let recently = recently else {
            self.recently = now
            return
        }
        let interval = now.timeIntervalSince(recently)
        intervalArray.append(interval)
        if intervalArray.count > 10 {
            intervalArray.remove(at: 0)
        }
        var add: TimeInterval = 0
        for interval in intervalArray {
            add += interval
        }
        let bit = add / Double(intervalArray.count)
        let bpm = 60 / bit
        updateBPMLabel(bpm: Int(bpm))
        self.recently = now
    }
    
    private func updateBPMLabel(bpm: Int) {
        bpmLabel.text = String(bpm)
    }
    
}

