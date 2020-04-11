//
//  PostRowView.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/04/11.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct PostRowView: View {
    var post: PostModel
    var body: some View {
        VStack {
            HStack {
                Text(post.name)
                Text("@\(post.uid)")
            }
            Text(post.mess)
        }
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(post: PostModel(mess: "sample", name: "sample_name", uid: "sample_id"))
    }
}
