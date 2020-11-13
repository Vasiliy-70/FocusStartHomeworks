//
//  MasterViewController.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

protocol CellSelectedDelegate: class {
    func cellSelected(data: DataModel)
}

class MasterViewController: UIViewController {

    let menuData: [DataModel] = DataModel.getData()
    
    weak var delegate: CellSelectedDelegate?
    
    @IBOutlet weak var tableView: UITableView!
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentCell = tableView.dequeueReusableCell(withIdentifier: MasterTableViewCell.identifier,
                                                              for: indexPath) as? MasterTableViewCell
        else { assertionFailure(); return UITableViewCell() }
        
        currentCell.addItem(title: self.menuData[indexPath.row].title, description: self.menuData[indexPath.row].description,
                            time: self.menuData[indexPath.row].time)
        return currentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = menuData[indexPath.row]
        self.delegate?.cellSelected(data: cellData)
        
        if let detailViewController = self.delegate as? DetailViewController,
           let detailNavigationController = detailViewController.navigationController {
            self.splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

