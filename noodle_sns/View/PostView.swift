//
//  PostView.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/04/12.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var fireviewmodel: FireViewModel
    @State var mess: String = ""
    var body: some View {
        HStack {
            Spacer()
            TextField("投稿", text: $mess)
                .navigationBarTitle("ラーメンSNS", displayMode: .inline)
                .navigationBarItems(trailing:
                    HStack {
                        Button(action:{self.fireviewmodel.SignOut()}){
                            Image(systemName: "arrowshape.turn.up.left.fill")}
                })
            Button(action: {self.fireviewmodel.post(message: self.mess)}){
                Image(systemName: "arrowtriangle.up.circle")
            }
            Spacer()
        }
            .border(Color.blue, width: 2)
            .cornerRadius(3)
            .padding()
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView().environmentObject(FireViewModel())
    }
}
