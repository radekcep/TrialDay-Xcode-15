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
    private let dogeView = DogeView(frame: .zero, keywords: Constant.keywords)
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
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(Spacing.l)
        }
    }
    
    func setupSubviews() {
        containerStackView.axis = .vertical
        containerStackView.distribution = .equalSpacing
        containerStackView.alignment = .fill
        
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = .zero
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
    TransactionDetailViewController()
}
