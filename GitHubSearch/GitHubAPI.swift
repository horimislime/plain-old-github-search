//
//  GitHubAPI.swift
//  GitHubSearch
//
//  Created by horimislime on 2018/01/13.
//  Copyright © 2018 horimislime. All rights reserved.
//

import Foundation

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

enum APIError: Error {
    
    case noResponse
    case parseFailed
    case raw(NSError)
    
    var localizedDescription: String {
        switch self {
        case .noResponse: return "Empty response."
        case .parseFailed: return "Parsing JSON failed."
        case .raw(let error): return error.description
        }
    }
}

struct GitHubAPI {
    
    static let shared = GitHubAPI()
    
    func searchRepositories(withQuery query: String, withCompletionHandler completionHandler: @escaping (Result<SearchRepositoryResponse, APIError>) -> Void) {
        
        debugPrint("query = '\(query)'")
        var components = URLComponents(string: "https://api.github.com/search/repositories")!
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        
        let task = URLSession.shared.dataTask(with: components.url!) { data, _, error in
            
            if let error = error {
                completionHandler(.failure(.raw(error as NSError)))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode(SearchRepositoryResponse.self, from: data)
                completionHandler(.success(result))
                
            } catch {
                completionHandler(.failure(.parseFailed))
            }
        }
        task.resume()
    }
}
