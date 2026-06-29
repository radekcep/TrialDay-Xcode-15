//
//  TransactionCell.swift
//  Trial
//
//  Created by Radek on 27.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    private let verticalStackView = UIStackView()
    private let titlesAmountStackView = UIStackView()
    private let titlesStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let amountLabel = AmountPillView()
    private let lineItemsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        constraintSubviews()
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

private extension TransactionCell {
    func addSubviews() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titlesAmountStackView)
        verticalStackView.addArrangedSubview(lineItemsLabel)
        titlesAmountStackView.addArrangedSubview(titlesStackView)
        titlesAmountStackView.addArrangedSubview(amountLabel)
        titlesStackView.addArrangedSubview(titleLabel)
        titlesStackView.addArrangedSubview(subtitleLabel)
    }
    
    func constraintSubviews() {
        verticalStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Spacing.m)
            make.verticalEdges.equalToSuperview().inset(Spacing.s)
        }
    }
    
    func setupSubviews() {
        contentView.backgroundColor = UIColor(resource: .background)
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = Spacing.xs
        
        titlesAmountStackView.axis = .horizontal
        titlesAmountStackView.alignment = .center
        titlesAmountStackView.distribution = .fill
        titlesAmountStackView.spacing = Spacing.s
        
        titlesStackView.axis = .vertical
        
        titleLabel.textColor = UIColor(resource: .primary)
        titleLabel.font = .title
        
        subtitleLabel.textColor = UIColor(resource: .text)
        subtitleLabel.font = .subtitle
        subtitleLabel.numberOfLines = .zero
        
        lineItemsLabel.textColor = UIColor(resource: .text)
        lineItemsLabel.font = .lightBody
        lineItemsLabel.numberOfLines = .zero
    }
}

extension TransactionCell {
    func load(_ transaction: TransactionsViewModel.ViewState.Transaction) {
        titleLabel.text = transaction.title
        subtitleLabel.text = transaction.subtitle
        lineItemsLabel.text = transaction.lineItems
        
        if let amount = transaction.amount {
            amountLabel.load(amount, isNegative: transaction.isNegative)
            amountLabel.isHidden = false
        } else {
            amountLabel.isHidden = true
        }
    }
}

// MARK: - Preview

@available(iOS 18, *)
#Preview {
    let transaction = TransactionsViewModel.ViewState.Transaction(
        title: "MA 10 Wiener Kindergaerten",
        subtitle: Optional("MA 10 Wiener Kindergaerten/Wilma Ri"),
        lineItems: Optional("MA 10 Wiener Kindergaerten/Wilma Rinner/Elternbeitraege Wiener Kindergaert/PDezember 2017 V121282892"),
        amount: Optional("-65,35"),
        isNegative: true
    )
    
    let cell = TransactionCell()
    cell.load(transaction)
    
    return cell
}
