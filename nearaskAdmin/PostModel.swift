//
//  PostModel.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 6/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import Foundation


class PostModel {
    let uuid: String!
    let title: String
    let formattedPrice: String
    let description: String
    let location: Location
    let user: User
    let lastCreateAt: String
    let serviceCategory: ServiceCategory
    let medias: [Media]
    
    init (uuid: String, title: String, formattedPrice: String, description: String, location: Location, user: User, lastCreateAt: String, serviceCategory: ServiceCategory, medias: [Media]) {
        self.uuid = uuid
        self.title = title
        self.formattedPrice = formattedPrice
        self.description = description
        self.location = location
        self.user = user
        self.lastCreateAt = lastCreateAt
        self.serviceCategory = serviceCategory
        self.medias = medias
    }
}
