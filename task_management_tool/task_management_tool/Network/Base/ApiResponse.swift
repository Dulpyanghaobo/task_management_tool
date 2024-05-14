//
//  ApiResponse.swift
//  task_management_tool
//
//  Created by i564407 on 5/13/24.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T?
}
