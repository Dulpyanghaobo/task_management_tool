//
//  APIEnvironment.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import Foundation

struct AppEnvironment {
    static var baseURL: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "APIBaseURL") as? String,
              let url = URL(string: "http://"+urlString) else {
            fatalError("APIBaseURL is not set in plist for this environment")
        }
        print("\(urlString)")
        return url
    }
}


