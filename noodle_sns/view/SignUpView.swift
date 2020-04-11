//
//  SignUpView.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/04/10.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var mail: String = ""
    @State var pass: String = ""
    @EnvironmentObject var fireviewmodel: FireViewModel
    var body: some View {
        VStack{
            if self.fireviewmodel.pushSignUp {
                HomeView()
            } else {
                TextField("メールアドレス", text: $mail)
                SecureField("パスワード", text: $pass)
                Button(action: {self.fireviewmodel.SignIn(mail: self.mail, pass: self.pass)}){
                    Text("ログイン")
                }
                Button(action: {self.fireviewmodel.add(mail: self.mail, pass: self.pass)}){
                    Text("新規登録")
                }
                Text(self.fireviewmodel.loginMess)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(FireViewModel())
    }
}
