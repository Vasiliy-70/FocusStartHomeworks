//
//  ViewController.swift
//  Homework-3_UITabBar
//
//  Created by user183355 on 31.10.2020.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: LifeCycle
    
    override func loadView() {
        super.view = SecondView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SecondTask"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

