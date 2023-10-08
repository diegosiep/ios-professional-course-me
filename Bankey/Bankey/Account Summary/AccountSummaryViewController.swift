//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Diego Sierra on 06/10/23.
//

import UIKit


class AccountSummaryViewController: UIViewController {
    let games = [
    "Pacman",
    "Space Invaders",
    "Space Patrol",
    "Super Mario 64",
    "Super Mario Sunshine"
    ]
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
}

extension AccountSummaryViewController {
   private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var cellContentConfiguration = UIListContentConfiguration.cell()
        cellContentConfiguration.text = games[indexPath.row]
        cell.contentConfiguration = cellContentConfiguration
        return cell
    }
    
}

extension AccountSummaryViewController: UITableViewDelegate {
    
}
