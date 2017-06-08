//
//  Location.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 8/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import Foundation


class Location {
    let name: String
    let latitude: Float
    let longitude: Float

    
    init (name: String, latitude: Float, longitude: Float) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
