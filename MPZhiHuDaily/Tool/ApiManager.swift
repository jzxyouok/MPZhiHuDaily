//
//  ApiManager.swift
//  MPZhiHuDaily
//
//  Created by Maple on 2017/8/20.
//  Copyright © 2017年 Maple. All rights reserved.
//

import UIKit
import Moya

enum ApiManager {
    case getLaunchImg
    case getNewsList
    case getMoreNews(String)
    case getThemeList
    case getThemeDesc(Int)
    case getNewsDesc(Int)
}

extension ApiManager: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        get {
            return URL.init(string: "http://news-at.zhihu.com/api/")!
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        get {
            switch self {
            case .getLaunchImg:
                return "7/prefetch-launch-images/750*1142"
            case .getNewsList:
                return "4/news/latest"
            case .getMoreNews(let date):
                return "4/news/before/" + date
            case .getThemeList:
                return "4/themes"
            case .getThemeDesc(let id):
                return "4/theme/\(id)"
            case .getNewsDesc(let id):
                return "4/news/\(id)"
            }
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        get {
            return .get
        }
    }
    
    /// The parameters to be encoded in the request.
    var parameters: [String: Any]? {
        get {
            return nil
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        get {
            return URLEncoding.default
        }
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        get {
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        get {
            return .request
        }
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        get {
            return false
        }
    }
}
