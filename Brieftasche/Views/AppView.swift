//
//  AppView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .homeScreen:
            HomeView()
        case .signInScreen:
            SignInView()
        case .signUpScreen:
            SignUpView()
        case .splashScreen:
            SplashView()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
