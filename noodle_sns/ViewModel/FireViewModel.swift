//
//  FireViewModel.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/04/11.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Combine
import Firebase
import SwiftUI

class FireViewModel: ObservableObject {
    
    @Published var pushSignUp = false
    @Published var loginMess: String = "ログインしてください"
    @Published var messList: [PostModel] = []
    var DBRef:DatabaseReference!
    var userID: String = ""
    
    init() {
        DBRef = Database.database().reference()
        DBRef.child("messages").observe(.childAdded, with: { [weak self](snapshot) -> Void in
            let message = String(describing: snapshot.childSnapshot(forPath: "message").value!)
            let uid = String(describing: snapshot.childSnapshot(forPath: "uid").value!)
            self?.DBRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                self?.messList.insert(PostModel(mess: message, name: name, uid: uid), at:0)
            }) { (error) in
                print(error.localizedDescription)
            }
        })
    }
    
    func post(message: String) {
        let data = ["message": message, "uid": self.userID]
        self.DBRef.child("messages").childByAutoId().setValue(data)
    }
    
    func addName(name: String){
        let data = ["name": name]
        self.DBRef.child("users").child(self.userID).setValue(data)
    }
    
    
    
    func add(mail: String, pass: String) {
        Auth.auth().createUser(withEmail: mail, password: pass, completion: { user, error in
            if let error = error {
                print("Creating the user failed! \(error)")
                self.loginMess = "失敗しました"
                return
            }

            if let user = user {
                self.pushSignUp.toggle()
                self.userID = Auth.auth().currentUser?.uid as! String
                print(self.userID)
                print("user : \(String(describing: user.user.email)) has been created successfully.")
            }
        })
    }
    
    func SignIn(mail :String, pass: String){
        Auth.auth().signIn(withEmail: mail, password: pass) { user, error in
            if error != nil {
                print("login failed! \(String(describing: error))")
                self.loginMess = "失敗しました"
                return
            }

            if let user = user {
                self.pushSignUp.toggle()
                self.userID = Auth.auth().currentUser?.uid as! String
                print(self.userID)
                print("user : \(String(describing: user.user.email)) has been signed in successfully.")
            }
        }
    }
    
    func SignOut(){
        try? Auth.auth().signOut()
        self.pushSignUp.toggle()
        self.userID = ""
        self.loginMess = "ログアウトしました"
    }
    
}
