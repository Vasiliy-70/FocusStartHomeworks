//
//  DataModel.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import Foundation

struct DataModel {
    let title: String
    
    static func getData() -> [Self] {
        return [
            DataModel(title: "Title1"),
            DataModel(title: "Title2"),
            DataModel(title: "Title3"),
            DataModel(title: "Title4"),
            DataModel(title: "Title5")
        ]
    }
}
