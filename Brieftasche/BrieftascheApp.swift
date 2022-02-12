//
//  BrieftascheApp.swift
//  Brieftasche
//
//  Created by Lloyd on 2/10/22.
//

import Firebase
import SwiftUI

@main
struct BrieftascheApp: App {
    
    @StateObject var viewRouter = ViewRouter()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            AppView().environmentObject(viewRouter)
        }
    }
}
