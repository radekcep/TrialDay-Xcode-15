//
//  TransactionCell.swift
//  Trial
//
//  Created by Radek on 27.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    private let horizontalStackView = UIStackView()
    private let verticalStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let lineItemsLabel = UILabel()
    private let amountLabel = UILabel()
    
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
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(amountLabel)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
        verticalStackView.addArrangedSubview(lineItemsLabel)
    }
    
    func constraintSubviews() {
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupSubviews() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .top
        horizontalStackView.distribution = .fill
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
    }
}

extension TransactionCell {
    func load(_ transaction: TransactionsViewModel.ViewState.Transaction) {
        titleLabel.text = transaction.title
        subtitleLabel.text = transaction.subtitle
        lineItemsLabel.text = transaction.lineItems
        amountLabel.text = transaction.amount
    }
}

// MARK: - Preview

@available(iOS 18, *)
#Preview {
    let transaction = TransactionsViewModel.ViewState.Transaction(
        title: "MA 10 Wiener Kindergaerten",
        subtitle: Optional("MA 10 Wiener Kindergaerten/Wilma Ri"),
        lineItems: Optional("MA 10 Wiener Kindergaerten/Wilma Rinner/Elternbeitraege Wiener Kindergaert/PDezember 2017 V121282892"),
        amount: Optional("-65,35")
    )
    
    let cell = TransactionCell()
    cell.load(transaction)
    
    return cell
}
