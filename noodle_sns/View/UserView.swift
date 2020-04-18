//
//  UserView.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/04/11.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var fireviewmodel: FireViewModel
    @State var userName: String = ""
    var body: some View {
        VStack {
            Text(fireviewmodel.userName)
            TextField("ユーザ名", text: $userName)
            Button(action: {self.fireviewmodel.addName(name: self.userName)}){
                Text("ユーザー名の変更")
            }
            Button(action: {self.fireviewmodel.SignOut()}){
                Text("ログアウト")
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView().environmentObject(FireViewModel())
    }
}
