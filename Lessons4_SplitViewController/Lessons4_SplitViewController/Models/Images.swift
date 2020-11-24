//
//  Images.swift
//  Lessons4_SplitViewController
//
//  Created by Admin on 09.11.2020.
//

import UIKit
enum Images: String {
    case chau_chau = "chau_chau"
    case haski = "haski"
    case picines = "picines"
    case retriver = "retriver"
    case spitz = "spitz"
    
    var firstImage: UIImage {
        guard let image = UIImage(named: self.rawValue + "_1")
        else { assertionFailure(); return UIImage() }
        return image
    }
    
    var secondImage: UIImage {
        guard let image = UIImage(named: self.rawValue + "_2")
        else { assertionFailure(); return UIImage() }
        return image
    }
}
