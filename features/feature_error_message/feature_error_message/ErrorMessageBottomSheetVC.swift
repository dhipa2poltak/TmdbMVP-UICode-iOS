//
//  ErrorMessageBottomSheetView.swift
//  feature_error_message
//
//  Created by user on 07/04/24.
//

import UIKit
import app_framework

public class ErrorMessageBottomSheetVC: BottomSheetViewController {

    private var errorMessage = ""

    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()

    private lazy var lblTitle: UILabel = {
        let view = UILabel()
        view.text = "Message"
        return view
    }()

    private lazy var lblMessage: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()

    private lazy var btnDismiss: UIButton = {
        let view = UIButton()
        view.setTitle("Dismiss", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()

    public init(errorMessage: String) {
        super.init(nibName: nil, bundle: nil)
        self.errorMessage = errorMessage
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        lblMessage.text = errorMessage
        btnDismiss.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)

        contentStackView.addArrangedSubview(lblTitle)
        contentStackView.addArrangedSubview(lblMessage)
        contentStackView.addArrangedSubview(btnDismiss)

        self.setContent(content: contentStackView)
    }

    @objc private func handleDismissButton() {
        self.dismissBottomSheet()
    }
}
