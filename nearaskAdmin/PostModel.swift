//
//  PostModel.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 6/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import Foundation


class PostModel {
    let username: String
    let firsName: String
    let lastName: String
    
    init (un: String, fn: String, ln: String) {
        self.username = un
        self.firsName = fn
        self.lastName = ln
    }
}
