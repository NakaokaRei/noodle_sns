//
//  URLImage.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/05/06.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct URLImage: View {

    let url: String
    @ObservedObject private var imageDownloader = ImageDownloader()

    init(url: String) {
        self.url = url
        self.imageDownloader.downloadImage(url: self.url)
    }

    var body: some View {
        if let imageData = self.imageDownloader.downloadData {
            let img = UIImage(data: imageData)
            return VStack {
                Image(uiImage: img!).resizable()
            }
        } else {
            return VStack {
                Image(uiImage: UIImage(systemName: "icloud.and.arrow.down")!).resizable()
            }
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "")
    }
}
