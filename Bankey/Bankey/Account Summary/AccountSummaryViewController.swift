//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Diego Sierra on 06/10/23.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    var accounts: [AccountSummaryCell.ViewModel] = []
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHeaderView()
        fetchData()
    }
    
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
    }
    
    private func setupHeaderView() {
        let header = AccountSummaryHeaderView(frame: .zero)
        
        //        UIScreen.main.bounds.width will no longer work. the following property must be accessed, instead.
        let scenes  = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        guard let screenBoundsWidth = window?.screen.bounds.width else { return }
        
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = screenBoundsWidth
        header.frame.size = size
        
        tableView.tableHeaderView = header
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
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
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        
        return cell
    }
    
}

extension AccountSummaryViewController: UITableViewDelegate {
    
}

extension AccountSummaryViewController {
    private func fetchData() {
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings", balance: 929466.23)
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Visa Avion Card", balance: 412.83)
        let investment = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "No-Fee All-In Checking", balance: 17562.42)
        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Student Mastercard", balance: 50.83)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Growth Fund", balance: 15000.15161)
        
        accounts.append(savings)
        accounts.append(visa)
        accounts.append(investment)
        accounts.append(investment2)
        accounts.append(masterCard)
        accounts.append(chequing)
    }
}

