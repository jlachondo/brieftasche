//
//  ProfileLink.swift
//  Brieftasche
//
//  Created by Lloyd on 2/16/22.
//

import Foundation

struct ProfileLink: Identifiable {
    var id: String
    let action: String?
    let iconName: String
    let name: String
    
    init(action: String?, iconName: String, name: String) {
        self.id = name
        self.action = action
        self.iconName = iconName
        self.name = name
    }
}
