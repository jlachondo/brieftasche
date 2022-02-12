//
//  AuthUtil.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import Firebase
import Foundation

struct AuthUtil {
    func handleFirAuthError(error: NSError) -> String {
        if AuthErrorCode(rawValue: error.code) != nil {
            let invalidCredsMsg = "Invalid email/password, please check your inputs and try again."
            print("Firebase error code: \(error.code)")

            switch error.code {
            case 17011:
                return invalidCredsMsg
            default:
                return error.localizedDescription
            }
        } else {
            return "Something went wrong while logging in, please try again."
        }
    }
}
