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

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return viewModel.movieList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListTableViewCell = tableView.dequeueCell(with: indexPath)
        cell.titleLabel.text = viewModel.movieList[indexPath.row].title
        cell.descLabel.text = viewModel.movieList[indexPath.row].overview
        let posterLink = viewModel.movieList[indexPath.row].posterLink
        if let url = posterLink {
            cell.posterImageView.load(url: url, placeholder: nil)
        }

        return cell
    }

}
