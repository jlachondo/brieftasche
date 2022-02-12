//
//  ViewRouter.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import SwiftUI

class ViewRouter: ObservableObject {

    @Published var currentPage: Page = .splashScreen

}

enum Page {
    case homeScreen
    case signInScreen
    case signUpScreen
    case splashScreen
}
