//
//  AmountPillView.swift
//  Trial
//
//  Created by Radek on 29.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import UIKit

class AmountPillView: UIView {
    private let pillView = UIView()
    private let amountLabel = UILabel()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pillView.layer.cornerRadius = pillView.frame.height / 2
    }
}

// MARK: - UI Setup

private extension AmountPillView {
    func addSubviews() {
        addSubview(pillView)
        pillView.addSubview(amountLabel)
    }
    
    func constraintSubviews() {
        pillView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        amountLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.s)
        }
    }
    
    func setupSubviews() {
        amountLabel.font = .boldBody
        amountLabel.textColor = UIColor(resource: .text)
        amountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        amountLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
}

extension AmountPillView {
    func load(_ amount: String, isNegative: Bool) {
        pillView.backgroundColor = isNegative ? UIColor(resource: .negativeBackground) : UIColor(resource: .positiveBackground)
        amountLabel.text = amount
    }
}

// MARK: - Preview

@available(iOS 18, *)
#Preview {
    let amountPillView = AmountPillView()
    amountPillView.load("42,00", isNegative: true)
    
    return amountPillView
}
