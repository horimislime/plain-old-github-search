//
//  SearchResultCell.swift
//  GitHubSearch
//
//  Created by horimislime on 2018/01/13.
//  Copyright © 2018 horimislime. All rights reserved.
//

import UIKit

final class SearchResultCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var updatedAtLabel: UILabel!
    
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starCountLabel: UILabel!
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    func update(withRepository repository: RepositoryResponse) {
        
        nameLabel.text = repository.fullName
        descriptionLabel.text = repository.description
        descriptionLabel.isHidden = (repository.description == nil)
        
        updatedAtLabel.text = formatter.string(from: repository.updatedAt)
        
        languageLabel.text = repository.language
        starCountLabel.isHidden = (repository.starCount == 0)
        
        if repository.starCount > 1000 {
            let countString = String(format: "%.1f", Double(repository.starCount) / 1000.0)
            starCountLabel.text = "\(countString)k ⭐️"
            
        } else if repository.starCount > 0 {
            starCountLabel.text = "\(repository.starCount) ⭐️"
            
        } else {
            starCountLabel.text = nil
        }
    }
}
