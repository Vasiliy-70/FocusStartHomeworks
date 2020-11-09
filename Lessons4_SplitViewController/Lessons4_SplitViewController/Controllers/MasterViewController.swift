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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentCell = tableView.dequeueReusableCell(withIdentifier: MasterTableViewCell.identifier,
                                                              for: indexPath) as? MasterTableViewCell
        else { assertionFailure(); return UITableViewCell() }
        
        currentCell.addItem(title: menuData[indexPath.row].title, description: menuData[indexPath.row].description,
                            time: menuData[indexPath.row].time)
        return currentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = menuData[indexPath.row]
        delegate?.cellSelected(data: cellData)
        
        if let detailViewController = delegate as? DetailViewController,
           let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

