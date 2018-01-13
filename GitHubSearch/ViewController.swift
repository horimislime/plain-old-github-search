//
//  ViewController.swift
//  GitHubSearch
//
//  Created by horimislime on 2018/01/13.
//  Copyright © 2018 horimislime. All rights reserved.
//

import SafariServices
import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.autocapitalizationType = .none
        }
    }
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    fileprivate var throttle = Throttle(runInterval: 1.0)
    fileprivate var repositories = [RepositoryResponse]() {
        didSet {
            tableView.separatorStyle = repositories.isEmpty ? .none : .singleLine
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}

// MARK: - Search Bar

extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText.count > 0 else {
            repositories = []
            return
        }
        
        if repositories.isEmpty {
            loadingView.startAnimating()
        }
        
        throttle.execute {
            GitHubAPI.shared.searchRepositories(withQuery: searchText) { [weak self] result in
                guard let strongSelf = self else { return }
                
                DispatchQueue.main.async {
                    strongSelf.loadingView.stopAnimating()
                    switch result {
                    case .success(let response):
                        strongSelf.repositories = response.items
                    case .failure(let error):
                        strongSelf.showAlert(withMessage: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Table View

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let safari = SFSafariViewController(url: repositories[indexPath.row].url)
        present(safari, animated: true, completion: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchResultCell.self)) as! SearchResultCell
        cell.update(withRepository: repositories[indexPath.row])
        return cell
    }
}
