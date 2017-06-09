    //
//  ServiceCategory.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 8/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import Foundation

class ServiceCategory {
    let id: NSNumber
    let name: String
    let iconName: String
    let backgroundUrl: String
    
    init(id: NSNumber, name: String, iconName: String, backgroundUrl: String) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.backgroundUrl = backgroundUrl
    }
    
    static func getIconBycategoryname(catid: NSNumber) -> String {
        switch catid {
        case 1:
            return ""
        case 2:
            return ""
        case 3:
            return ""
        case 4:
            return ""
        case 5:
            return ""
        case 6:
            return "" //
        case 7:
            return "" //
        case 8:
            return "" //
        case 9:
            return "" //
        case 10:
            return "" //
        case 11:
            return "" //
        case 12:
            return "" //
        case 13:
            return "" //
        case 14:
            return "" //
        default:
            return "" //
        }
    }
    
    static func getAllCategories() -> [String] {
        return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15" ]
    }
    
}
