//
//  CellContent.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 05.11.2020.
//

import UIKit

struct CellContent {
    let title: String
    let textContent: String
    let time: String
    
    static func contentData() -> [Self] {
        return [
            CellContent(title: "Title1", textContent: "Text", time: "20:13"),
            CellContent(title: "The very big Title 2", textContent: "Text", time: "20:13"),
            CellContent(title: "Title3", textContent: "A lot of text; A lot of text", time: ""),
            CellContent(title: "Title4", textContent: "A lot of text; A lot of text", time: "20:13"),
            CellContent(title: "Title5", textContent: "", time: "")
        ]
    }
}
