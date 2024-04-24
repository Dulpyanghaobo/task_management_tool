//
//  AuthService.swift
//  task_management_tool
//
//  Created by i564407 on 4/19/24.
//

import Moya
import Foundation

enum AuthService {
    case register(name: String, email: String, password: String)
    case login(email: String, password: String)
    case verifyActivityCode(email: String, code: String)
    case sendActivityCode(email: String, code: String)
    case clearAccount(userId: String, password: String)
    
    case sendPasswordResetCode(email: String)
    case sendPasswordVerifyCode(email: String, code: String)
    case resetPassword(email: String, password: String)

}

extension AuthService: TargetType {
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL {
        return APIEnvironment.baseURL(for: .v1)
    }
    
    var path: String {
        switch self {
        case .register:
            return "/auth/register"
        case .login:
            return "/auth/login"
        case .verifyActivityCode:
            return "/auth/activity/verify"
        case .sendPasswordResetCode:
            return "/auth/password/reset/code"
        case .sendPasswordVerifyCode:
            return "/auth/password/reset/verify"
        case .resetPassword:
            return "/auth/password/reset"
        case .sendActivityCode:
            return "/auth/activity/code/create"
        case .clearAccount:
            return "/auth/account/clear"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register, .login, .sendPasswordResetCode, .sendActivityCode, .resetPassword, .clearAccount, .verifyActivityCode, .sendPasswordVerifyCode:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .register(let name, let email, let password):
            return .requestParameters(
                parameters: ["name": name, "email": email, "password": password],
                encoding: JSONEncoding.default
            )
        case .login(let email, let password):
            return .requestParameters(
                parameters: ["email": email, "password": password],
                encoding: JSONEncoding.default
            )
        case .sendPasswordResetCode(let email):
            return .requestParameters(
                parameters: ["email": email],
                encoding: JSONEncoding.default
            )
        case  .sendActivityCode(let email, let code):
            return .requestParameters(
                parameters: ["email": email, "code": code],
                encoding: JSONEncoding.default
            )
        case .resetPassword(let email, let newPassword):
            return .requestParameters(
                parameters: ["email": email, "newPassword": newPassword],
                encoding: JSONEncoding.default
            )
        case .verifyActivityCode(email: let email, code: let code):
            return .requestParameters(
                parameters: ["token": code, "email": email],
                encoding: JSONEncoding.default
            )
        case .clearAccount(userId: let email, password: let password):
            return .requestParameters(
                parameters: ["email": email, "password": password],
                encoding: JSONEncoding.default
            )
        case .sendPasswordVerifyCode(email: let email, code: let code):
            return .requestParameters(
                parameters: ["email": email, "code": code],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var sampleData: Data {
        switch self {
        case .register, .login, .sendPasswordResetCode, .sendActivityCode, .verifyActivityCode, .sendPasswordVerifyCode, .resetPassword, .clearAccount:
            return Data()
        }
    }
}
