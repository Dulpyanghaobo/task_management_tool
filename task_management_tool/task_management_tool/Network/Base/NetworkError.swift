//
//  NetworkError.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case unknown
}
