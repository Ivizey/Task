//
//  DataLoader.swift
//  Breweries
//
//  Created by Pavel Bondar on 20.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol ResponseValidator {
    func validate(_ response: HTTPURLResponse) throws
}

enum ResponseValidationError: Error {
    case unacceptableCode(Int)
}

struct StatusCodeValidator: ResponseValidator {
    func validate(_ response: HTTPURLResponse) throws {
        guard (200...299).contains(response.statusCode) else {
            throw ResponseValidationError.unacceptableCode(response.statusCode)
        }
    }
}

protocol URLSessionDescribing {
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
        -> URLSessionDataTask
}

extension URLSession: URLSessionDescribing {}

typealias DataLoaderHandler = (Swift.Result<Data, EndpointError>) -> Void

protocol DataLoader {
    func request(_ endpoint: Endpoint, then handler: @escaping DataLoaderHandler)
}

class DataLoaderImpl: DataLoader {
    private let session: URLSessionDescribing
    private let responseValidator: ResponseValidator
    
    init(session: URLSessionDescribing,
         validator: ResponseValidator) {
        self.session = session
        self.responseValidator = validator
    }
    
    func request(_ endpoint: Endpoint,
                 then handler: @escaping DataLoaderHandler) {
        guard let url = endpoint.url else {
            return handler(.failure(EndpointError.invalidURL))
        }

        let task = session.dataTask(with: url) { [responseValidator] data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                handler(.failure(.invalidResponse(response)))
                return
            }
            
            do {
                try responseValidator.validate(httpResponse)
            } catch {
                handler(.failure(.validation(error)))
            }
            
            let result = data.map(Result.success) ??
                        .failure(EndpointError.network(error))

            handler(result)
        }

        task.resume()
    }
}
