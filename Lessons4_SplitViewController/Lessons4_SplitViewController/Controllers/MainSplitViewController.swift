//
//  MainSplitViewController.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 06.11.2020.
//

import UIKit

class MainSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.preferredDisplayMode = .oneBesideSecondary
    }
    
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}
