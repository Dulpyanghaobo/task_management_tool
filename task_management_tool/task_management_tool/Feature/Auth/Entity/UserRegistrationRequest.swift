//
//  UserRegistrationRequest.swift
//  task_management_tool
//
//  Created by i564407 on 5/13/24.
//

import Foundation

struct UserRegistrationRequest: Encodable {
    let userName: String
    let avatar: String
    let email: String
    let password: String
}
