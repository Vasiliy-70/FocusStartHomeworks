//
//  Body.swift
//  Lessons1_CarAccounting
//
//  Created by Admin on 24.10.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum Body: Int, CaseIterable
{
    case hatchback = 1
    case minivan
    case sedan
    case offRoad
    
    var name: String {
        switch self {
        case .hatchback:
            return "Хэтчбек"
        case .minivan:
            return "Минивэн"
        case .sedan:
            return "Седан"
        case .offRoad:
            return "Внедорожник"
        }
    }
}
