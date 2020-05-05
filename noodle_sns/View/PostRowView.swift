//
//  PostRowView.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/04/11.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI
import Firebase
import UIKit

struct PostRowView: View {
    var post: PostModel
    var body: some View {
        VStack {
            HStack {
                Text(post.name)
                Text("@\(post.uid)")
            }
            Text(post.mess)
            Text(post.date)
            URLImage(url: post.image_url)
            .scaledToFill()
            .frame(width: 200, height: 200)
            .border(Color.black, width: 1)
            .clipped()
            .padding()
        }
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(post: PostModel(mess: "sample", name: "sample_name", uid: "sample_id", date: "2014/07/28 17:11:29", created: 100, image_url: ""))
    }
}
