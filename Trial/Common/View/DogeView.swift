//
//  DogeView.swift
//  Trial
//
//  Created by Radek on 26.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import UIKit
import SnapKit

class DogeView: UIView {
    private let dogeImageContainerView = UIView()
    private let dogeImage = UIImage(resource: .doge)
    private lazy var dogeImageView = UIImageView(image: dogeImage)
    private let keywords: [String]
    private var animationTask: Task<(), Never>?
    
    init(frame: CGRect = .zero, keywords: [String]) {
        self.keywords = keywords
        super.init(frame: frame)
        
        addSubviews()
        constraintSubviews()
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        animationTask?.cancel()
    }
}

// MARK: - UI Setup

private extension DogeView {
    func addSubviews() {
        addSubview(dogeImageContainerView)
        dogeImageContainerView.addSubview(dogeImageView)
    }
    
    func constraintSubviews() {
        dogeImageContainerView.snp.makeConstraints { make in
            make.edges.lessThanOrEqualToSuperview().inset(Constant.imageInsets)
            make.center.equalToSuperview()
            make.width.equalTo(dogeImageContainerView.snp.height).multipliedBy(dogeImage.size.width / dogeImage.size.height)
        }
        dogeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupSubviews() {
        dogeImageContainerView.layer.cornerRadius = Constant.imageCornerRadius
        dogeImageContainerView.layer.shadowColor = Constant.imageShadowColor.cgColor
        dogeImageContainerView.layer.shadowOffset = Constant.imageShadowOffset
        dogeImageContainerView.layer.shadowOpacity = Constant.imageShadowOpacity
        dogeImageContainerView.layer.shadowRadius = Constant.imageShadowRadius
        
        dogeImageView.layer.cornerRadius = Constant.imageCornerRadius
        dogeImageView.layer.masksToBounds = true
        
        startAnimationLoop()
    }
}

// MARK: - Animated Text Effects

private extension DogeView {
    func startAnimationLoop() {
        animationTask = Task {
            while !Task.isCancelled {
                guard let keyword = keywords.randomElement(),
                      let color = Constant.textColors.randomElement()
                else { return }
                
                add(text: keyword, in: color)
                let delay: TimeInterval = .random(in: Constant.textAdditionInterval)
                try? await Task.sleep(nanoseconds: UInt64(delay * Double(NSEC_PER_SEC)))
            }
        }
    }
    
    func add(text: String, in color: UIColor) {
        let label = UILabel()
        label.alpha = .zero
        label.text = text
        label.textColor = color
        label.font = .boldBody
        label.transform = CGAffineTransform(scaleX: Constant.textInOutScale, y: Constant.textInOutScale)
        
        let randomCoordinates = CGPoint(
            x: .random(in: .zero...dogeImageView.bounds.width),
            y: .random(in: .zero...dogeImageView.bounds.height)
        )
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(randomCoordinates)
        }
                
        UIView.animate(
            withDuration: .random(in: Constant.textInOutAnimationDuration),
            delay: .zero,
            animations: {
                label.alpha = 1
                label.transform = .identity
            }
        )
        
        UIView.animate(
            withDuration: .random(in: Constant.textInOutAnimationDuration),
            delay: .random(in: Constant.textOnscreenAnimationDuration),
            animations: {
                label.alpha = 0
                label.transform = CGAffineTransform(scaleX: Constant.textInOutScale, y: Constant.textInOutScale)
            },
            completion: { _ in label.removeFromSuperview() }
        )
    }
}

// MARK: - Constant

private enum Constant {
    static let imageInsets: CGFloat = Spacing.m
    static let imageCornerRadius: CGFloat = 25
    
    static let imageShadowColor = UIColor.black
    static let imageShadowOffset = CGSize(width: 0, height: 4)
    static let imageShadowOpacity: Float = 0.2
    static let imageShadowRadius: CGFloat = 8
    
    static let textColors = [UIColor.magenta, .systemPink, .systemOrange, .yellow, .green, .blue, .red]
    static let textInOutScale = 0.95
    static let textAdditionInterval: ClosedRange<TimeInterval> = 0.3...1
    static let textInOutAnimationDuration: ClosedRange<TimeInterval> = 0.3...0.5
    static let textOnscreenAnimationDuration: ClosedRange<TimeInterval> = 1...3
}

// MARK: - Preview

@available(iOS 18, *)
#Preview {
    DogeView(keywords: [
        "Wow",
        "Such preview",
        "Many words",
        "Very animated",
        "So meme",
    ])
}
