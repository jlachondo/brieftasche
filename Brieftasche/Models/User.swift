//
//  User.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import Foundation

struct User: Identifiable {
    let id: String
    let email: String
    let isEmailVerified: Bool
    let firstName: String
    let lastName: String
    
    // Just added some placeholders here to appear in the preview simulator
    init (docData: [String: Any]) {
        self.id = docData["id"] as? String ?? ""
        self.email = docData["email"] as? String ?? "johndoe@email.com"
        self.isEmailVerified = docData["isEmailVerified"] as? Bool ?? false
        self.firstName = docData["firstName"] as? String ?? "John"
        self.lastName = docData["lastName"] as? String ?? "Doe"
    }
}
