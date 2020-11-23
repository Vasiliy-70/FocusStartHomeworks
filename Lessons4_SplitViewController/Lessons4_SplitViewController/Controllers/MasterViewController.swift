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

final class MasterViewController: UIViewController {
    private let menuData: [DataModel] = DataModel.getData()
    weak var delegate: CellSelectedDelegate?
    
    @IBOutlet private weak var tableView: UITableView!
	
	enum Constants {
		static let defaultRow = 0
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupDefaultRow(atIndex: Constants.defaultRow)
	}
}

extension MasterViewController {
	func setupDefaultRow(atIndex: Int) {
		self.tableView.selectRow(at: IndexPath(row: atIndex, section: 0), animated: false, scrollPosition: .top)
		self.delegate?.cellSelected(data: menuData[atIndex])
	}
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
			self.delegate = detailViewController
			self.delegate?.cellSelected(data: cellData)
            self.splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

