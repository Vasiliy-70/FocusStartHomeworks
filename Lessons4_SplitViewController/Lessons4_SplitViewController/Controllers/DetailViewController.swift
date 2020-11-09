//
//  DetailViewController.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var firstImageView: UIImageView!
    
    @IBOutlet weak var secondImageView: UIImageView!
    
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
        descriptionLabel.text = dataModel?.description
        self.title = dataModel?.title
        self.firstImageView.image = dataModel?.image.first
        self.secondImageView.image = dataModel?.image.last
    }
}

extension DetailViewController: CellSelectedDelegate {
    func cellSelected(data: DataModel) {
        self.dataModel = data
    }
}
