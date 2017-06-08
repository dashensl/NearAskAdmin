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
    
}
