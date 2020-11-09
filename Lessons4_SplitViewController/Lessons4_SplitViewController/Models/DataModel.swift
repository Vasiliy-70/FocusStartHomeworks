//
//  DataModel.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import Foundation

struct DataModel {
    let title: String
    let description: String
    let time: String
    
    static func getData() -> [Self] {
        return [
            DataModel(title: "Чау-чау", description: "Роскошная львиная грива - фиолетовый язык", time: "00:01"),
            DataModel(title: "Померанский\nшпиц", description: "Пушистый колобочек", time: "00:02"),
            DataModel(title: "Сибирский хаски", description: "Сибирский хаски – одна из древнейших пород собак",
                      time: ""),
            DataModel(title: "Золотистый ретривер", description: "Золотистый ретривер – отличный компаньон и лучший друг охотника. Добродушен, спокоен, великолепно апортирует подстреленную дичь.", time: "00:03"),
            DataModel(title: "Пикинес", description: "", time: "")
        ]
    }
}
