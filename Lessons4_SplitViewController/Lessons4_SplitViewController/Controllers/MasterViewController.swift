//
//  MasterViewController.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

class MasterViewController: UIViewController {

    let menuData: [MenuData] = MenuData.getData()
    
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
        guard let currentCell = tableView.dequeueReusableCell(withIdentifier: MasterTableViewCell.identifier, for: indexPath) as? MasterTableViewCell
        else { assertionFailure(); return UITableViewCell() }
        
        currentCell.addItem(title: menuData[indexPath.row].title)
        return currentCell
    }
}

