//
//  BottomSheetViewController.swift
//  app_framework
//
//  Created by user on 07/04/24.
//

import UIKit
import SnapKit

open class BottomSheetViewController: UIViewController {
    // MARK: - UI
    /// Main bottom sheet container view
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    /// View to to hold dynamic content
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    /// Top bar view that draggable to dismiss
    lazy var topBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white//.lightGray.withAlphaComponent(0.1)
        return view
    }()


    /// Top view bar
    lazy var barLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        return view
    }()

    /// Dimmed background view
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    lazy var vwContent: UIView = {
        let view = UIView()
        return view
    }()

    // MARK: - Properties

    /// Maximum alpha for dimmed view
    private let maxDimmedAlpha: CGFloat = 0.8
    /// Minimum drag vertically that enable bottom sheet to dismiss
    private let minDismissiblePanHeight: CGFloat = 20
    /// Minimum spacing between the top edge and bottom sheet
    public var minTopSpacing: CGFloat = 80

    // MARK: - View Setup
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresent()
    }

    private func setupViews() {
        view.backgroundColor = .clear

        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Container View
        view.addSubview(mainContainerView)
        mainContainerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.greaterThanOrEqualTo(view.snp.top).offset(minTopSpacing)
        }

        // Top draggable bar view
        mainContainerView.addSubview(topBarView)
        topBarView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(22)
        }

        topBarView.addSubview(barLineView)
        barLineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(40)
            make.height.equalTo(8)
        }

        // Content View
        mainContainerView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(topBarView.snp.bottom)
            make.bottom.equalToSuperview().offset(-32)
        }
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDimmedView))
        dimmedView.addGestureRecognizer(tapGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        topBarView.addGestureRecognizer(panGesture)
    }

    @objc private func handleTapDimmedView() {
        dismissBottomSheet()
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // get drag direction
        let isDraggingDown = translation.y > 0
        guard isDraggingDown else { return }

        let pannedHeight = translation.y
        let currentY = self.view.frame.height - self.mainContainerView.frame.height
        // handle gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            self.mainContainerView.frame.origin.y = currentY + pannedHeight
        case .ended:
            // When user stop dragging
            // if fulfil the condition dismiss it, else move to original position
            if pannedHeight >= minDismissiblePanHeight {
                dismissBottomSheet()
            } else {
                self.mainContainerView.frame.origin.y = currentY
            }
        default:
            break
        }
    }

    private func animatePresent() {
        dimmedView.alpha = 0
        mainContainerView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.mainContainerView.transform = .identity
        }
        // add more animation duration for smoothness
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }

    public func dismissBottomSheet() {
        UIView.animate(withDuration: 0.2, animations: {  [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = self.maxDimmedAlpha
            self.mainContainerView.frame.origin.y = self.view.frame.height
        }, completion: {  [weak self] _ in
            self?.dismiss(animated: false)
        })
    }

    public func setContent(content: UIView) {
        //let contentStackView = content
        contentView.addSubview(scrollView)
        scrollView.addSubview(vwContent)
        vwContent.addSubview(content)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        vwContent.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        content.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }

        view.layoutIfNeeded()

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.contentView.heightAnchor.constraint(equalToConstant: self.vwContent.frame.height).isActive = true
        }
    }
}
