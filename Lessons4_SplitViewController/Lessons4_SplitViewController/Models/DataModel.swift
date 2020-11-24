//
//  DataModel.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

struct DataModel {
    let title: String
    let description: String
    let time: String
    let image: [UIImage]
    
    static func getData() -> [Self] {
        return [
            DataModel(title: "Чау-чау", description: "Роскошная львиная грива - фиолетовый язык", time: "00:01",
                      image: [Images.chau_chau.firstImage, Images.chau_chau.secondImage]),
            DataModel(title: "Померанский\nшпиц", description: "Пушистый колобочек", time: "00:02",
                      image: [Images.spitz.firstImage, Images.spitz.secondImage]),
            DataModel(title: "Сибирский хаски", description: "Сибирский хаски – одна из древнейших пород собак", time: "",
                      image: [Images.haski.firstImage, Images.haski.secondImage]),
            DataModel(title: "Золотистый ретривер", description:
                        """
                        Золотистый ретривер – отличный компаньон и лучший друг охотника.
                        Добродушен, спокоен, великолепно апортирует подстреленную дичь.
                        """, time: "00:03",
                      image: [Images.retriver.firstImage, Images.retriver.secondImage]),
           DataModel(title: "Пикинес", description: "", time: "",
                     image: [Images.picines.firstImage, Images.picines.secondImage])
        ]
    }
}
