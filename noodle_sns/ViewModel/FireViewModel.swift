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
import UIKit

class FireViewModel: ObservableObject{
    
    @Published var pushSignUp = false
    @Published var loginMess: String = "ログインしてください"
    @Published var messList: [PostModel] = []
    @Published var userName: String = ""
    var DBRef:DatabaseReference!
    var userID: String = ""
    
    init() {
        DBRef = Database.database().reference()
        DBRef.child("messages")
            .observe(.childAdded, with: { [weak self](snapshot) -> Void in
                let message = String(describing: snapshot.childSnapshot(forPath: "message").value!)
                let uid = String(describing: snapshot.childSnapshot(forPath: "uid").value!)
                let date = String(describing: snapshot.childSnapshot(forPath: "date").value!)
                let image = self?.getImageByUrl(url: String(describing: snapshot.childSnapshot(forPath: "image_url").value!)) 
                let created = snapshot.childSnapshot(forPath: "created").value!
                self?.DBRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let name = value?["name"] as? String ?? ""
                    self?.messList.insert(PostModel(mess: message, name: name, uid: uid, date: date, created: created as! Int, image: image!), at:0)
                }){(error) in
                    print(error.localizedDescription)
                }
            })
    }
    
    //投稿
    func post(message: String, image: UIImage) {
        let now1 = NSDate()
        let now2 = NSDate()
        let formatter1 = DateFormatter()
        let formatter2 = DateFormatter()
        formatter1.dateFormat = "yyyyMMddHHmmss000"
        formatter2.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let created = formatter1.string(from: now1 as Date)
        let date = formatter2.string(from: now2 as Date)
        let uuid = NSUUID().uuidString
        guard let imageData = image.jpegData(compressionQuality: 0.3) else {return}
        let imageRef = Storage.storage().reference().child("postImages/\(uuid).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if error != nil {
                print("Unable to upload image.")
                return
            }
            imageRef.downloadURL { (url, error) in
                if error != nil {
                    print("Unable to download URL.")
                }
                guard url != nil else { return }
                //print(url!)
                let data = ["message": message, "uid": self.userID, "date": date, "created": Int(created) as Any, "image_url": url!.absoluteString as NSString]
                self.DBRef.child("messages").childByAutoId().setValue(data)
            }
        }
    }
    
    //ユーザーネーム変更
    func addName(name: String){
        let data = ["name": name]
        self.DBRef.child("users").child(self.userID).setValue(data)
        self.getUserName()
    }
    
    //アカウント新規作成
    func add(mail: String, pass: String) {
        Auth.auth().createUser(withEmail: mail, password: pass, completion: { user, error in
            if let error = error {
                print("Creating the user failed! \(error)")
                self.loginMess = "失敗しました"
                return
            }

            if let user = user {
                self.pushSignUp.toggle()
                self.getUserId()
                self.addName(name: "ユーザー名なし")
                self.getUserName()
                self.messList = self.messList.sorted(by: { (a, b) -> Bool in
                    return a.created > b.created
                })
                print(self.userID)
                print("user : \(String(describing: user.user.email)) has been created successfully.")
            }
        })
    }
    
    //ログイン
    func SignIn(mail :String, pass: String){
        Auth.auth().signIn(withEmail: mail, password: pass) { user, error in
            if error != nil {
                print("login failed! \(String(describing: error))")
                self.loginMess = "ログインできませんでした"
                return
            }

            if let user = user {
                self.pushSignUp.toggle()
                self.getUserId()
                self.messList = self.messList.sorted(by: { (a, b) -> Bool in
                    return a.created > b.created
                })
                self.getUserName()
                print(self.userID)
                print("user : \(String(describing: user.user.email)) has been signed in successfully.")
            }
        }
    }
    
    //ログアウト
    func SignOut(){
        //try? Auth.auth().signOut()
        self.pushSignUp.toggle()
        self.userID = ""
        self.loginMess = "ログアウトしました"
    }
    
    func getUserName(){
        self.DBRef.child("users").child(self.userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.userName = value?["name"] as? String ?? ""
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getUserId(){
        self.userID = Auth.auth().currentUser?.uid ?? ""
    }
    
    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
    
}
