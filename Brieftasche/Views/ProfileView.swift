//
//  ProfileView.swift
//  Brieftasche
//
//  Created by Lloyd on 2/16/22.
//

import Firebase
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user = User(docData: [:])
    
    func fetchUserDetails() {
        let currUser = Auth.auth().currentUser
        if let currUser = currUser {
            // The user's ID, unique to the firebase project.
            let uid = currUser.uid
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(uid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    print(document)
                    print(document.data()!)
                    let doc = document.data()!
                    self.user = User(docData: doc)
                } else {
                    // Do nothing
                    print("Document does not exist - fetchUserDetails")
                }
            }
        }
    }
}

struct ProfileView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var userVM = UserViewModel()
    
    @State var hasSignOutError = false
    @State var isSigningOut = false
    
    let profileLinks: [ProfileLink] = [
        ProfileLink(action: "about", iconName: "info.circle.fill", name: "About the app"),
        ProfileLink(action: "contactAndSupport", iconName: "bubble.left.and.exclamationmark.bubble.right.fill", name: "Contact and Support"),
        ProfileLink(action: "changePassword", iconName: "lock.fill", name: "Change Password"),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            if !userVM.user.id.isEmpty {
                HStack(spacing: 20) {
                    // User Profile Picture
                    Image("kazuma_1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                        )
                    
                    // User Details
                    VStack(alignment: .leading) {
                        // Name
                        Text("\(userVM.user.firstName) \(userVM.user.lastName)")
                            .foregroundColor(UIConfig.secondaryFontColor)
                            .font(UIConfig.mediumFont)
                            .lineLimit(2)
                        
                        // Email address
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(Color.white)
                            Text(verbatim: userVM.user.email)
                                .foregroundColor(UIConfig.secondaryFontColor)
                                .font(UIConfig.smallFont)
                                .lineLimit(2)
                        }
                        .padding(.trailing, 20)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 250)
                .padding()
                .background(UIConfig.primaryBtnBGColor)
                
                // Verify email link
                Divider()
                VStack(spacing: 0) {
                    Button {
                        print("Verify email pressed")
                    } label: {
                        ClassicListView(isPressable: !userVM.user.isEmailVerified, text: userVM.user.isEmailVerified ? "Email is verified" : "Verify email")
                    }
                    .disabled(userVM.user.isEmailVerified)
                    Divider()
                }
                .padding(.bottom, 50)
                
                // Other profile links
                Divider()
                ForEach(profileLinks) { profileLink in
                    Button {
                        handleProfileLinks(action: profileLink.action!)
                    } label: {
                        VStack(spacing: 0) {
                            ClassicListView(imageName: profileLink.iconName, text: profileLink.name)
                            Divider()
                        }
                    }
                    
                }
                Spacer()
                
                // Sign out link
                Divider()
                Button {
                    if !isSigningOut {
                        signOutUser()
                    }
                } label: {
                    VStack(spacing: 0) {
                        ClassicListView(imageName: "rectangle.portrait.and.arrow.right.fill", isLoading: true, isPressable: !isSigningOut, text: isSigningOut ? "Signing out..." : "Sign out")
                        Divider()
                    }
                }
                .alert("Something went wrong while signing out, please try again.", isPresented: $hasSignOutError) {
                    Button("Ok", role: .cancel) { }
                }
                .disabled(isSigningOut)
            } else {
                // Show progress view while fetching user details
                ProgressView()
            }
        }
        .onAppear {
            userVM.fetchUserDetails()
        }
    }
    
    private func handleProfileLinks(action: String) {
        if action == "about" {
            print("About the app pressed")
        } else if action == "contactAndSupport" {
            print("Contact and Support pressed")
        } else if action == "changePassword" {
            print("Change Password pressed")
        }
    }
    
    private func signOutUser() {
        isSigningOut = true
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            withAnimation {
                viewRouter.currentPage = .signInScreen
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            hasSignOutError = true
            isSigningOut = false
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
