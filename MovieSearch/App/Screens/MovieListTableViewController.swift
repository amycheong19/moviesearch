//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Amy Cheong on 30/4/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, ViewModelable, ErrorMessageDisplayable {

    typealias ViewModel = MovieListViewModel
    var viewModel: ViewModel! = ViewModel()
    lazy var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Movie"
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false

        navigationItem.searchController = searchController
        definesPresentationContext = true


        tableView.rowHeight = UITableView.automaticDimension        
        viewModel.tableDataHandler = { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListTableViewCell = tableView.dequeueCell(with: indexPath)
        cell.titleLabel.text = viewModel.movies[indexPath.row].title
        cell.descLabel.text = viewModel.movies[indexPath.row].overview
        let posterLink = viewModel.movies[indexPath.row].posterLink
        if let url = posterLink {
            cell.posterImageView.load(url: url, placeholder: nil)
        }

        // Check if the last row number is the same as the last current data element
        if indexPath.row == viewModel.movies.count - 1 {
            viewModel.getMovie(by: searchController.searchBar.text!, reset: false)
        }
        return cell
    }

}

// MARK: -UISearchBarDelegate
extension MovieListTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text  else { return }
        viewModel.getMovie(by: text)
    }
}
