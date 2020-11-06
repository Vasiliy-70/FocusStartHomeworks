//
//  MasterViewController.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 05.11.2020.
//

import UIKit

class MasterViewController: UIViewController {
    
    let data: [CellContent] = CellContent.contentData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let masterCell = tableView.dequeueReusableCell(
                withIdentifier: MasterTableViewCell.identifier, for: indexPath)
                as? MasterTableViewCell else { assertionFailure(); return UITableViewCell()}
        
        masterCell.addData(title: data[indexPath.row].title,
                           textContent: data[indexPath.row].textContent,
                           time: data[indexPath.row].time)
        
        return masterCell
    }
    
    
    
}
