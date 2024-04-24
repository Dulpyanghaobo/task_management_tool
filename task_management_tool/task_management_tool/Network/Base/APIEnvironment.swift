//
//  APIEnvironment.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import Foundation

enum APIVersion {
    case v1
    case v2
}

struct APIEnvironment {
    static let currentVersion: APIVersion = .v1
    static func baseURL(for version: APIVersion) -> URL {
        switch version {
        case .v1:
            guard let urlString = Bundle.main.object(forInfoDictionaryKey: "APIBaseURL") as? String,
                  let url = URL(string: "http://"+urlString+"/api/v1") else {
                fatalError("APIBaseURL is not set in plist for this environment")
            }
            return url
        case .v2:
            guard let urlString = Bundle.main.object(forInfoDictionaryKey: "APIBaseURL") as? String,
                  let url = URL(string: "http://"+urlString+"/api/v2") else {
                fatalError("APIBaseURL is not set in plist for this environment")
            }
            return url
        }
    }
}



