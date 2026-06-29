//
//  TransactionDetailViewController.swift
//  Trial
//
//  Created by Radek on 28.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import UIKit
import RxCocoa
import RxSwift
import SnapKit

class TransactionDetailViewController: UIViewController {
    private let containerStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let dogeView = DogeView(keywords: Constant.keywords)
    private let viewIsMovingFromParent = PublishSubject<Void>()
    private var viewModel: TransactionDetailViewModel!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        constraintSubviews()
        setupSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            viewIsMovingFromParent.onNext(())
        }
    }
}

// MARK: - UI Setup

private extension TransactionDetailViewController {
    func addSubviews() {
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(subtitleLabel)
        containerStackView.addArrangedSubview(dogeView)
    }
    
    func constraintSubviews() {
        containerStackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(Spacing.l)
        }
    }
    
    func setupSubviews() {
        view.backgroundColor = UIColor(resource: .background)
        
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        containerStackView.alignment = .fill
        containerStackView.spacing = Spacing.l
        
        containerStackView.setCustomSpacing(Spacing.s, after: titleLabel)
        
        titleLabel.font = .heavyTitle
        titleLabel.textColor = UIColor(resource: .text)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = .zero
        
        subtitleLabel.font = .subtitle
        subtitleLabel.textColor = UIColor(resource: .text)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = .zero
    }
}

// MARK: - ViewModel Binding

extension TransactionDetailViewController {
    var viewModelInput: TransactionDetailViewModel.InputFromView {
        .init(
            viewIsMovingFromParent: viewIsMovingFromParent.asObservable()
        )
    }
    
    func bind(viewModel: TransactionDetailViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.outputToView.title
        subtitleLabel.text = viewModel.outputToView.subtitle
    }
}

// MARK: - DI

extension Container {
    var transactionDetailViewController: Factory<TransactionDetailViewController> {
        self(TransactionDetailViewController.init)
    }
}

// MARK: - Constant

private enum Constant {
    static let keywords = [
        "Wow",
        "Much money",
        "So transaction",
        "Very expensive",
    ]
}

// MARK: - Preview

@available(iOS 18, *)
#Preview {
    func makeViewController() -> UIViewController {
        let transaction = Trial.Transaction(
            id: "D3E0BD0330B14C01",
            title: "MA 10 Wiener Kindergaerten",
            subtitle: Optional(
                "MA 10 Wiener Kindergaerten/Wilma Ri"
            ),
            sender: Trial.AccountNumber(
                iban: Optional(
                    "AT601200051428010635"
                ),
                bic: Optional(
                    "BKAUATWWXXX"
                ),
                number: nil,
                bankCode: nil,
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    "AT"
                )
            ),
            senderName: Optional(
                "Stadt Wien"
            ),
            senderOriginator: Optional(
                "MA 10 Wiener Kindergaerten"
            ),
            senderReference: "002202296141",
            senderBankReference: nil,
            receiver: Trial.AccountNumber(
                iban: Optional(
                    "AT552011182743536500"
                ),
                bic: Optional(
                    "GIBAATWWXXX"
                ),
                number: Optional(
                    "82743536500"
                ),
                bankCode: Optional(
                    "20111"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    "AT"
                )
            ),
            receiverName: Optional(
                "Birgit Anna Mayer"
            ),
            receiverReference: "",
            creditorId: "AT03MAG00000009679",
            amount: Trial.Amount(
                value: -6535,
                precision: 2,
                currency: "EUR"
            ),
            amountSender: Trial.Amount(
                value: -6535,
                precision: 2,
                currency: "EUR"
            ),
            bookingDate: Date(timeIntervalSince1970: 1518390000),
            valuationDate: Date(timeIntervalSince1970: 1518390000),
            importDate: Date(timeIntervalSince1970: 1518403980),
            dueDate: nil,
            exchangeDate: nil,
            insertTimestamp: Date(timeIntervalSince1970: 1518407555),
            reference: "1200018020810550037217259240",
            originatorSystem: "SD*/EZG",
            additionalTexts: Trial.AdditionalTexts(
                text1: "MA 10 Wiener Kindergaerten/Wilma Ri",
                text2: "MA 10 Wiener Kindergaerten",
                text3: "MDID:00206579811000001",
                lineItems: [
                    "MA 10 Wiener Kindergaerten/Wilma Ri",
                    "nner/Elternbeitraege Wiener Kinderg",
                    "aert/PDezember 2017 V121282892"
                ],
                constantSymbol: nil,
                variableSymbol: nil,
                specificSymbol: nil
            ),
            note: nil,
            bookingType: "DU-BK-DD",
            bookingTypeTranslation: nil,
            orderRole: "RECEIVER",
            orderCategory: Optional(
                "DOMESTIC"
            ),
            cardId: "0000000000000000",
            maskedCardNumber: "",
            invoiceId: nil,
            location: "",
            partnerName: Optional(
                "Stadt Wien"
            ),
            partnerOriginator: Optional(
                "MA 10 Wiener Kindergaerten"
            ),
            partnerAddress: [
                "Neues Rathaus 1",
                "1080 Wien"
            ]
        )
        
        let viewController = TransactionDetailViewController()
        _ = viewController.view
        
        viewController.bind(viewModel: TransactionDetailViewModel(
            inputFromView: viewController.viewModelInput,
            inputFromCoordinator: .init(transaction: transaction)
        ))
        
        return UINavigationController(rootViewController: viewController)
    }
    
    return makeViewController()
}
