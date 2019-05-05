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
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Movie"
        searchController.searchBar.delegate = self
        let searchBar = searchController.searchBar
        searchBar.tintColor = .white
        searchBar.barTintColor = .white

        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {

                // Background color
                backgroundview.backgroundColor = UIColor.white

                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        return searchController
    }()

    let spinner = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()

        viewModel.tableDataHandler = { [weak self] _ in
            self?.tableView.reloadData()
        }

        // Loading for listing (
        viewModel.loadingDataHandler = { [weak self] isLoading in
            if isLoading {
                self?.spinner.startAnimating()
            } else {
                self?.spinner.stopAnimating()
            }
            self?.tableView.tableFooterView?.isHidden = !isLoading
        }

        // Loading for poster images
        viewModel.loadImageDataHandler = { [weak self] (data, indexPath) in
            guard let `self` = self,
                let data = data, let indexPath = indexPath,
                let img = UIImage(data: data) else { return }

            DispatchQueue.main.async{
                // Before we assign the image, check whether the current cell is visible
                if let updateCell = self.tableView.cellForRow(at: indexPath) as? MovieListTableViewCell {
                    updateCell.posterImageView.image = img
                }
            }
        }
    }

    // MARK: - Layout
    // Everything about UI setup
    private func layout() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true

        tableView.rowHeight = UITableView.automaticDimension

        tableView.tableFooterView = spinner
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
        let movie = viewModel.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.descLabel.text = movie.overview
        cell.posterImageView.image = #imageLiteral(resourceName: "Placeholder")
        
        if let url = movie.posterLink {
            if let data = viewModel.imageCache.object(forKey: url as AnyObject) as? Data,
                let img = UIImage(data: data) {
                // Cached image used, no need to download it
                cell.posterImageView.image = img
            } else {
                viewModel.getImage(with: url, indexPath: indexPath)
            }
        }

        // Load more movies
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
