//
//  ErrorView.swift
//  Trial
//
//  Created by Radek on 28.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import UIKit
import RxSwift

class ErrorView: UIView {
    private let containerStackView = UIStackView()
    private let dogeView = DogeView(keywords: Constant.keywords)
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let retryButton = UIButton()
    
    var retryButtonTap: Observable<Void> {
        retryButton.rx.tap.asObservable()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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

private extension ErrorView {
    func addSubviews() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        containerStackView.addArrangedSubview(dogeView)
        containerStackView.addArrangedSubview(retryButton)
    }
    
    func constraintSubviews() {
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.l)
        }
    }
    
    func setupSubviews() {
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        containerStackView.alignment = .center
        containerStackView.spacing = Spacing.m
        
        containerStackView.setCustomSpacing(Spacing.xs, after: titleLabel)
        
        titleLabel.text = "Something went wrong"
        titleLabel.textColor = UIColor(resource: .text)
        titleLabel.font = .title
        
        descriptionLabel.textColor = UIColor(resource: .text)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = .zero
        
        retryButton.setTitle("Retry", for: .normal)
        retryButton.configuration = .primary
    }
}

extension ErrorView {
    func load(_ description: String?) {
        descriptionLabel.text = description
    }
}

// MARK: - Constant

private enum Constant {
    static let keywords = [
        "Oh no",
        "Such shame",
        "Very disappointed",
        "Retry pls",
        "So bad",
    ]
}

// MARK: - Preview

@available(iOS 18, *)
#Preview {
    let errorView = ErrorView()
    errorView.load("The operation couldn't be completed. (Trial.APIError error O.)")
    
    return errorView
}
