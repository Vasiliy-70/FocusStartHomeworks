//
//  MainSplitViewController.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

final class MainSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
		
		if let detailViewController = (self.viewControllers.last as? UINavigationController)?.topViewController as? DetailViewController,
		   let masterViewController = (self.viewControllers.first as? UINavigationController)?.topViewController as? MasterViewController {
			masterViewController.delegate = detailViewController
		}
    }
    
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}
