//
//  ImageDownloader.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/05/06.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Foundation

class ImageDownloader : ObservableObject {
    @Published var downloadData: Data? = nil

    func downloadImage(url: String) {

        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.downloadData = data
            }
        }
    }
}
