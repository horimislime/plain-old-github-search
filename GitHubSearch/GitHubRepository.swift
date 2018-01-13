//
//  GitHubRepository.swift
//  GitHubSearch
//
//  Created by horimislime on 2018/01/13.
//  Copyright © 2018 horimislime. All rights reserved.
//

import Foundation

struct SearchRepositoryResponse: Decodable {
    
    var items: [RepositoryResponse]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(items: [RepositoryResponse]) {
        self.items = items
    }
    
    init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        let items = try? container?.decode(Array<RepositoryResponse>.self, forKey: .items) ?? []
        self.init(items: items!)
    }
}

struct RepositoryResponse: Decodable {
    
    var fullName: String
    var description: String?
    var language: String?
    var starCount: Int
    var updatedAt: Date
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case description
        case language
        case starCount = "stargazers_count"
        case updatedAt = "updated_at"
        case url = "html_url"
    }
}
