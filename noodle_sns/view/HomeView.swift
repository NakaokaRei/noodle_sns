//
//  HomeView.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/04/10.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var fireviewmodel: FireViewModel
    @State var mess: String = ""
    var body: some View {
        TabView{
            NavigationView{
                VStack {
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
                    List(self.fireviewmodel.messList){ post in
                        PostRowView(post: post)
                    }
                }
            }
                .tabItem{
                    VStack {
                        Image(systemName: "message")
                        Text("Post")
                    }
                }
            UserView()
                .tabItem{
                    VStack {
                        Image(systemName: "person.circle")
                        Text("User")
                    }
                    
                }
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(mess: "こんにちわ").environmentObject(FireViewModel())
    }
}
