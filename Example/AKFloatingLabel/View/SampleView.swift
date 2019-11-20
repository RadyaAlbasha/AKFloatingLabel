//
//  SampleView.swift
//  AKFloatingLabel_Example
//
//  Created by Diogo Autilio on 20/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SketchKit
import AKFloatingLabel

final class SampleView: UIView {

    var firstSeparator = LightGrayView()
    var dividerView = LightGrayView()
    var secondSeparator = LightGrayView()

    let titleField: AKFloatingLabelTextField = {
        let textField = AKFloatingLabelTextField(frame: .zero)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "Title",
                                                             attributes: [.foregroundColor: UIColor.darkGray])
        textField.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    let priceField: AKFloatingLabelTextField = {
        let textField = AKFloatingLabelTextField(frame: .zero)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "Price",
                                                             attributes: [.foregroundColor: UIColor.darkGray])
        textField.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        return textField
    }()

    let locationField: AKFloatingLabelTextField = {
        let textField = AKFloatingLabelTextField(frame: .zero)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "Specific Location (optional)",
                                                             attributes: [.foregroundColor: UIColor.darkGray])
        textField.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        return textField
    }()

    let descriptionField: AKFloatingLabelTextView = {
        let textView = AKFloatingLabelTextView(frame: .zero)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.placeholder = "Description"
        textView.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildViewHierarchy()
        self.setupConstraints()
        self.configureViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SampleView {

    func buildViewHierarchy() {
        self.addSubview(titleField)
        self.addSubview(firstSeparator)
        self.addSubview(priceField)
        self.addSubview(dividerView)
        self.addSubview(locationField)
        self.addSubview(secondSeparator)
        self.addSubview(descriptionField)
    }

    func setupConstraints() {

        titleField.layout.applyConstraint { make in
            make.topAnchor(equalTo: self.safeTopAnchor)
            make.leadingAnchor(equalTo: self.leadingAnchor, constant: 10)
            make.trailingAnchor(equalTo: self.trailingAnchor, constant: -10)
            make.heightAnchor(greaterThanOrEqualToConstant: 44)
        }

        firstSeparator.layout.applyConstraint { make in
            make.topAnchor(equalTo: self.titleField.bottomAnchor)
            make.leadingAnchor(equalTo: self.leadingAnchor)
            make.trailingAnchor(equalTo: self.trailingAnchor)
            make.heightAnchor(equalTo: 1)
        }

        priceField.layout.applyConstraint { make in
            make.topAnchor(equalTo: self.firstSeparator.bottomAnchor)
            make.leadingAnchor(equalTo: self.leadingAnchor, constant: 10)
            make.heightAnchor(greaterThanOrEqualToConstant: 44)
        }

        dividerView.layout.applyConstraint { make in
            make.leadingAnchor(equalTo: self.priceField.trailingAnchor, constant: 10)
            make.centerYAnchor(equalTo: self.priceField.centerYAnchor)
            make.widthAnchor(equalTo: 1)
            make.heightAnchor(equalTo: self.priceField.heightAnchor)
        }

        locationField.layout.applyConstraint { make in
            make.leadingAnchor(equalTo: self.dividerView.trailingAnchor, constant: 10)
            make.centerYAnchor(equalTo: self.dividerView.centerYAnchor)
            make.trailingAnchor(equalTo: self.trailingAnchor, constant: -10)
            make.heightAnchor(equalTo: self.priceField.heightAnchor)
        }

        secondSeparator.layout.applyConstraint { make in
            make.topAnchor(equalTo: self.priceField.bottomAnchor)
            make.leadingAnchor(equalTo: self.leadingAnchor)
            make.trailingAnchor(equalTo: self.trailingAnchor)
            make.heightAnchor(equalTo: 1)
        }

        descriptionField.layout.applyConstraint { make in
            make.topAnchor(equalTo: self.secondSeparator.bottomAnchor)
            make.leadingAnchor(equalTo: self.leadingAnchor, constant: 10)
            make.trailingAnchor(equalTo: self.trailingAnchor, constant: -10)
            make.bottomAnchor(equalTo: self.safeBottomAnchor, constant: -10)
        }
    }

    func configureViews() {

        self.titleField.floatingLabelTextColor = .brown
        self.titleField.clearButtonColor = .red
        self.titleField.keepBaseline = true

        self.priceField.floatingLabelTextColor = .brown

        self.locationField.floatingLabelTextColor = .brown

        self.descriptionField.placeholderTextColor = .darkGray
        self.descriptionField.floatingLabelTextColor = .brown
    }
}
