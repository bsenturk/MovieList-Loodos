//
//  Network.swift
//  MovieList
//
//  Created by Burak Şentürk on 23.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

protocol RequestBuilder {
    associatedtype Response: Decodable

    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension RequestBuilder {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "www.omdbapi.com"
    }
}

enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

enum ResultType {
    case success(Decodable)
    case failure(Error)
}

final class Network {

    func request<Request>(from request: Request, completion: @escaping (ResultType) -> Void) where Request: RequestBuilder {

        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        urlComponents.queryItems = request.queryItems

        let url = urlComponents.url!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue

        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in

            if let error = error {
                completion(.failure(error))
            }

            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    let decoder = JSONDecoder()
                    do {
                        guard let data = data else { return }
                        let decoded = try decoder.decode(Request.Response.self, from: data)
                        completion(.success(decoded))
                    } catch {
                        completion(.failure(error))
                    }

                default:
                    break
                }
            }

        }).resume()

    }

}
