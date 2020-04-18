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
            UserView()
                .tabItem{
                    VStack {
                        Image(systemName: "person.circle")
                        Text("User")
                    }
                }
            PostView()
                .tabItem{
                    VStack {
                        Image(systemName: "paperplane")
                        Text("Post")
                    }
                }
            NavigationView{
                List(self.fireviewmodel.messList){ post in
                    PostRowView(post: post)
                }
                    .navigationBarTitle("ラーメンSNS", displayMode: .inline)
            }
                .tabItem{
                    VStack {
                        Image(systemName: "message")
                        Text("Time Line")
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
