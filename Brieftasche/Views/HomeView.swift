//
//  HomeView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

// TODO: Move the firebase import in the profile view
import Firebase
import SwiftUI

struct HomeView: View {
    
    @State var selectedTab = 1
    
    //    TODO: Move this envObject & state in the profile view
    @EnvironmentObject var viewRouter: ViewRouter
    @State var isSigningOut = false
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIConfig.unselectedTabBGColor
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            //            TODO: Update the VStack to a View (e.g. ProfileView, DashboardView, HistoryView??, etc.)
            VStack {
                Text("Dashboard screen")
                    .padding(.bottom, 15)
                Button("Move to Second Tab") {
                    selectedTab = 2
                }
            }
            .tabItem {
                Label("Dashboard", systemImage: "chart.bar.doc.horizontal.fill")
            }
            .tag(1)
            
            VStack {
                Text("History screen")
                    .padding(.bottom, 15)
                Button("Move to Third Tab") {
                    selectedTab = 3
                }
            }
            .tabItem {
                Label("History", systemImage: "chart.pie.fill")
            }
            .tag(2)
            
            //            VStack {
            //                Text("Profile screen")
            //                    .padding(.bottom, 15)
            //
            //                Button("Move to First Tab") {
            //                    selectedTab = 1
            //                }
            //            }
            //            TODO: Update/improve this UI later
            NavigationView {
                Text("Profile screen")
                    .navigationTitle("Profile")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            if isSigningOut {
                                ProgressView()
                            } else {
                                Button("Sign Out") {
                                    signOutUser()
                                }
                            }
                        }
                    }
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
            .tag(3)
        }
        //        Use `tint` if you're targeting iOS 15 and later, else use `accentColor`
        //        .tint(.red)
        .accentColor(UIConfig.primaryBtnBGColor)
    }
    
    //    TODO: Move this function in the profile view
    private func signOutUser() {
        //        TODO: Update/improve the error handling here. Maybe an alert if there's an error??
        isSigningOut = true
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            withAnimation {
                viewRouter.currentPage = .signInScreen
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            isSigningOut = false
        }
        //        Not sure if this should be executed outside the try/catch, so I'll comment it in the meantime. Will revisit this later on.
        //        withAnimation {
        //            viewRouter.currentPage = .signInScreen
        //        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
