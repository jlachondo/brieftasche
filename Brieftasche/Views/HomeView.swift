//
//  HomeView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var selectedTab = 1
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIConfig.unselectedTabBGColor
        // TODO: Set background color to somethinng like gray/light gray
        UITabBar.appearance().backgroundColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 0.2)
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Dashboard Tab
            DashboardView()
            .tabItem {
                Label("Dashboard", systemImage: "chart.bar.doc.horizontal.fill")
            }
            .tag(1)
            
            // History Tab
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

            // Profile Tab
            ProfileView()
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle.fill")
            }
            .tag(3)
        }
        //        Use `tint` if you're targeting iOS 15 and later, else use `accentColor`
        //        .tint(.red)
        .accentColor(UIConfig.primaryBtnBGColor)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
