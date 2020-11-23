//
//  MasterTableViewCell.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

final class MasterTableViewCell: UITableViewCell {
    static let identifier = String(describing: MasterTableViewCell.self)
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var timeLabel: UILabel!
    
    func addItem(title: String, description: String, time: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.timeLabel.text = time
    }
}
