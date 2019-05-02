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
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }

}
