//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Diego Sierra on 11/10/23.
//

import UIKit

enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}

class AccountSummaryCell: UITableViewCell {
    
    /*   By keeping the enum and the ViewModel struct inside of the AccountSummaryCell class, you're basically telling the reader of this code that you'd like them to know that these data types are VERY specific to the AccountSummaryCell class; i.e. they should only be reused for this type of cell. You could declare them in a separate file but this is more ideal. */
    //    In a later lesson you take out the AccountType enum, to make it available to other types in this project, in order to support networking processes.
    
    
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    let viewModel: ViewModel? = nil
    
    let typeLabel = UILabel()
    let nameLabel = UILabel()
    let divider = UIView()
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(appColor, renderingMode: .alwaysOriginal))
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight = CGFloat(112)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell {
    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        contentView.addSubview(typeLabel) // If you don't do so in this way, and you follow the traditional 'addSubview(view)' method, things might not work right. This is how you do it for UITableViewCells
        
        divider.backgroundColor = appColor
        divider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(divider)
        
        nameLabel.text = "Account Name"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentView.addSubview(nameLabel)
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.text = "Some balance"
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.adjustsFontSizeToFitWidth = true
        balanceLabel.textAlignment = .right
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.adjustsFontSizeToFitWidth = true
        balanceAmountLabel.textAlignment = .right
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        contentView.addSubview(balanceStackView)
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chevronImageView)
        
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2 /* i.e. 16 */),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            divider.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            divider.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            divider.heightAnchor.constraint(equalToConstant: 4),
            divider.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: divider.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            balanceStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 0.5),
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: divider.topAnchor, multiplier: 0),
            
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: divider.topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    
}

extension AccountSummaryCell {
    func configure(with vm: ViewModel) {
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
        case .Banking:
            divider.backgroundColor = appColor
            balanceLabel.text = "Current Balance"
        case .CreditCard:
            divider.backgroundColor = .systemOrange
            balanceLabel.text = "Current Balance"
        case .Investment:
            divider.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}



