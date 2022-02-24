//
//  SplashView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import Firebase
import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    @State var isChecking: Bool = false
    
    var body: some View {
        VStack {
            if isChecking {
                if isActive {
                    HomeView()
                } else {
                    SignInView()
                }
            } else {
                ZStack {
                    Color(UIConfig.primaryBgColor)
                        .edgesIgnoringSafeArea(.all)
                    LogoView()
                }
            }
        }
        .onAppear {
            checkUserIfSignedIn()
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            //                withAnimation {
            //                    self.isActive = true
            //                }
            //            }
        }
    }
    
    private func checkUserIfSignedIn() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print("checkUserIfSignedIn is called")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("checkUserIfSignedIn - dispatchQueue is called")
                withAnimation {
                    //                    Done displaying the splash screen
                    self.isChecking = true
                    
                    if user != nil {
                        print("Active user's email: \(user?.email ?? "None")" )
                        //                        An active user is found
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
