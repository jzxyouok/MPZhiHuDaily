//
//  Model.swift
//  MPZhiHuDaily
//
//  Created by Maple on 2017/8/20.
//  Copyright © 2017年 Maple. All rights reserved.
//

import UIKit
import HandyJSON

struct listModel: HandyJSON {
    var date: String?
    var stories: [storyModel]?
    var top_stories: [storyModel]?
}

/// 轮播图模型
struct storyModel: HandyJSON {
    var ga_prefix: String?
    var id: Int?
    var images: [String]? //list_stories
    var title: String?
    var type: Int?
    var image: String? //top_stories
    var multipic = false
}
