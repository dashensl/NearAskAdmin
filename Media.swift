//
//  Media.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 9/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import Foundation

class Media {
    let mediaTypeId: NSNumber!
    let url: String!
    let placeholderUrl: String?
    
    init(mediaTypeId: NSNumber, url: String, placeholderUrl: String) {
        self.mediaTypeId = mediaTypeId
        self.url = url
        self.placeholderUrl = placeholderUrl
    }
    
}
