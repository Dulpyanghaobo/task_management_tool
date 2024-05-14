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
                    do {
                         let statusCode = response.statusCode
                         if statusCode >= 200 && statusCode <= 299 {
                             let results = try JSONDecoder().decode(T.self, from: response.data)
                             completion(.success(results))
                         } else {
                             completion(.failure(.invalidResponse(statusCode)))
                         }
                     } catch {
                         completion(.failure(.unableToDecode))
                     }
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
            let statusCode = response.statusCode
            let error = self.parseErrorFromResponse(response)
            
            switch statusCode {
            case 400:
                return .badRequest
            case 401:
                return .unauthorized
            case 403:
                return .forbidden
            case 404:
                return .notFound
            case 409:
                return .conflict
            case 500...599:
                return .serverError
            default:
                return error ?? .unknown
            }
        } else {
            return .failed(moyaError)
        }
    }
    
    private func parseErrorFromResponse(_ response: Response) -> NetworkError? {
        guard let data = try? response.mapJSON() as? [String: Any],
              let message = data["message"] as? String else {
            return nil
        }
        return NetworkError.failed(NSError(domain: "NetworkError", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: message]))
    }
}
