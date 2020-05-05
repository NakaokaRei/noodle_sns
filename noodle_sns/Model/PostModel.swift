//
//  PostModel.swift
//  noodle_sns
//
//  Created by 中岡黎 on 2020/04/11.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Foundation
import UIKit

struct PostModel: Identifiable {
    var id = UUID()
    var mess: String
    var name: String
    var uid: String
    var date: String
    var created: Int
    var image_url: String
}
