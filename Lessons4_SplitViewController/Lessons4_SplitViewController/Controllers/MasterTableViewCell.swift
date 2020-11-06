//
//  MasterTableViewCell.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 05.11.2020.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    static let identifier = String(describing: MasterTableViewCell.self)
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textContent: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    func addData(title: String, textContent: String, time: String) {
        self.titleLabel.text = title
        self.textContent.text = textContent
        self.timeLabel.text = time
    }
    
}
