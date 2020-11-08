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
    
    func addItem(title: String) {
        print(title)
        self.titleLabel.text = title
    }
}
