//
//  User.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 8/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import Foundation


class User {
    let useruuid: String
    let username: String
    let profileThumbnailUrl: String
    
    init (useruuid: String, username: String, profileThumbnailUrl: String) {
        self.useruuid = useruuid
        self.username = username
        self.profileThumbnailUrl = profileThumbnailUrl
    }
}
