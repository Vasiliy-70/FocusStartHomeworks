//
//  Images.swift
//  Lessons3_UITabBar
//
//  Created by user183355 on 03.11.2020.
//

import UIKit

enum Images: String {
    case dog = "dog"
    
    var image: UIImage {
        guard let image = UIImage(named: self.rawValue) else { assertionFailure(); return UIImage()}
        return image
    }
}
