//
//  MenuData.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import Foundation

struct MenuData {
    let title: String
    
    static func getData() -> [Self] {
        return [
            MenuData(title: "Title1"),
            MenuData(title: "Title2"),
            MenuData(title: "Title3"),
            MenuData(title: "Title4"),
            MenuData(title: "Title5")
        ]
    }
}
