//
//  PostModel.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 6/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import Foundation


class PostModel {
    let title: String
    let formattedPrice: String
    let description: String
    let userUpdatedAt: String
    
    init (title: String, formattedPrice: String, description: String, userUpdatedAt: String) {
        self.title = title
        self.formattedPrice = formattedPrice
        self.description = description
        self.userUpdatedAt = userUpdatedAt
    }
}
