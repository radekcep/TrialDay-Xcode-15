//
//  SplashScreenViewController.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import FactoryKit
import UIKit
import RxCocoa
import SnapKit

class SplashScreenViewController: UIViewController {
    private let containerStackView = UIStackView()
    private let titleLabel = UILabel()
    private let dogeView = DogeView(keywords: Constant.keywords)
    private let actionButton = UIButton()
    private var viewModel: SplashScreenViewModel!
    
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
}

// MARK: - UI Setup

private extension SplashScreenViewController {
    func addSubviews() {
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(dogeView)
        containerStackView.addArrangedSubview(actionButton)
    }
    
    func constraintSubviews() {
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(Spacing.l)
        }
    }
    
    func setupSubviews() {
        view.backgroundColor = UIColor(resource: .background)
        
        containerStackView.axis = .vertical
        containerStackView.distribution = .equalSpacing
        containerStackView.alignment = .fill
        
        titleLabel.text = "Splash Screen"
        titleLabel.textColor = UIColor(resource: .text)
        titleLabel.font = .heavyTitle
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = .zero
        
        actionButton.setTitle("Close", for: .normal)
        actionButton.configuration = .primary
    }
}

// MARK: - ViewModel Binding

extension SplashScreenViewController {
    var viewModelInput: SplashScreenViewModel.InputFromView {
        .init(
            userClickedOnCTA: actionButton.rx.tap.asObservable()
        )
    }
    
    func bind(viewModel: SplashScreenViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - DI

extension Container {
    var splashScreenViewController: Factory<SplashScreenViewController> {
        self(SplashScreenViewController.init)
    }
}

// MARK: - Constant

private enum Constant {
    static let keywords = [
        "Wow",
        "Such app",
        "Many features",
        "Very modern",
        "So splash screen",
        "Clicky buttons",
        "Texty texts",
    ]
}

// MARK: - Preview

@available(iOS 18, *)
#Preview {
    SplashScreenViewController()
}
