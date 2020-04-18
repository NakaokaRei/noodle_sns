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
    @State var isShowingImagePicker = false
    @State var image = UIImage()
    var body: some View {
        VStack {
            HStack {
                Spacer()
                TextField("投稿", text: $mess)
                Button(action: {self.fireviewmodel.post(message: self.mess)}){
                    Image(systemName: "arrowtriangle.up.circle")
                }
                Button(action: {self.isShowingImagePicker.toggle()}){
                    Image(systemName: "camera")
                }.sheet(isPresented: $isShowingImagePicker, content: {
                    ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$image)
                })
                Spacer()
            }
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .border(Color.black, width: 1)
                .clipped()
                .padding()
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
