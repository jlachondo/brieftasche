//
//  DashboardView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            Text("Dashboard screen")
                .navigationTitle("Dashboard")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        if isSigningOut {
//                            ProgressView()
//                        } else {
//                            Button("Sign Out") {
//                                signOutUser()
//                            }
//                        }
//                    }
//                }
            // TODO: Pull to request, then customize it to press/open another view
            // TODO: Text for the total expenses today
            // TODO: List of expenses (with icons/emojis, about the expense, and the price)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
