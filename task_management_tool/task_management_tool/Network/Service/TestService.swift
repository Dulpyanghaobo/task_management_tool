//
//  TestService.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import Moya
import Foundation

enum TestService {
    case test
    case createUser(name: String, email: String)
}

extension TestService {
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL {
        return AppEnvironment.baseURL
    }
}

extension TestService: TargetType {
    
    var path: String {
        switch self {
        case .test:
            return "/test"
        case .createUser:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .test:
            return .get
        case .createUser:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .test:
            return .requestPlain  // No parameters for a GET request
        case .createUser(let name, let email):
            return .requestParameters(
                parameters: ["name": name, "email": email],
                encoding: JSONEncoding.default  // Encoding to JSON for a POST request
            )
        }
    }
}
