//
//  MasterTableViewCell.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    static let identifier = String(describing: MasterTableViewCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func addItem(title: String, description: String, time: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.timeLabel.text = time
    }
}
