//
//  UserViewModel.swift
//  Brieftasche
//
//  Created by Lloyd on 2/19/22.
//

import Firebase

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
