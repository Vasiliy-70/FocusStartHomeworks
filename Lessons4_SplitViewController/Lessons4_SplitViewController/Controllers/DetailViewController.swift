//
//  DetailViewController.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var dataModel: DataModel? {
        didSet {
            set()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func set() {
        self.loadViewIfNeeded()
        descriptionLabel.text = dataModel?.title
        self.title = dataModel?.title
    }
}

extension DetailViewController: CellSelectedDelegate {
    func cellSelected(data: DataModel) {
        self.dataModel = data
    }
}
