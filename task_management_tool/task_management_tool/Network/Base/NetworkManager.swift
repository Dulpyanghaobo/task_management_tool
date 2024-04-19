//
//  NetworkManager.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import Foundation
import Moya

protocol Networkable {
    associatedtype Target: TargetType
    var provider: MoyaProvider<Target> { get }
    func request<T: Decodable>(target: Target, completion: @escaping (Result<T, NetworkError>) -> Void)
}


class NetworkManager<Target: TargetType>: Networkable {
    var provider = MoyaProvider<Target>()

    func request<T: Decodable>(target: Target, completion: @escaping (Result<T, NetworkError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case let .failure(moyaError):
                let error = self.parseError(moyaError: moyaError)
                completion(.failure(error))
            }
        }
    }

    private func parseError(moyaError: MoyaError) -> NetworkError {
        if let response = moyaError.response {
            switch response.statusCode {
            case 400...499:
                return .badRequest
            case 500...599:
                return .serverError
            default:
                return .unknown
            }
        } else {
            return .failed
        }
    }
}

