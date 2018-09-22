//
//  ViewController.swift
//  AKFloatingLabel
//
//  Created by Diogo Autilio on 07/03/2017.
//  Copyright (c) 2017 Diogo Autilio. All rights reserved.
//

import UIKit
import AKFloatingLabel

class ViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Floating Label Demo"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.view.tintColor = .blue

        let floatingLabelColor = UIColor.brown

        let titleField = AKFloatingLabelTextField(frame: .zero)
        titleField.font = UIFont.systemFont(ofSize: 16)
        titleField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        titleField.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        titleField.floatingLabelTextColor = floatingLabelColor
        titleField.clearButtonMode = .whileEditing
        titleField.clearButtonColor = .red
        self.view.addSubview(titleField)
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.keepBaseline = true

        let div1 = UIView()
        div1.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.addSubview(div1)
        div1.translatesAutoresizingMaskIntoConstraints = false

        let priceField = AKFloatingLabelTextField(frame: .zero)
        priceField.font = UIFont.systemFont(ofSize: 16)
        priceField.attributedPlaceholder = NSAttributedString(string: "Price", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        priceField.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        priceField.floatingLabelTextColor = floatingLabelColor
        view.addSubview(priceField)
        priceField.translatesAutoresizingMaskIntoConstraints = false

        let div2 = UIView()
        div2.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.addSubview(div2)
        div2.translatesAutoresizingMaskIntoConstraints = false

        let locationField = AKFloatingLabelTextField(frame: .zero)
        locationField.font = UIFont.systemFont(ofSize: 16)
        locationField.attributedPlaceholder = NSAttributedString(string: "Specific Location (optional)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        locationField.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        locationField.floatingLabelTextColor = floatingLabelColor
        view.addSubview(locationField)
        locationField.translatesAutoresizingMaskIntoConstraints = false

        let div3 = UIView()
        div3.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.addSubview(div3)
        div3.translatesAutoresizingMaskIntoConstraints = false

        let descriptionField = AKFloatingLabelTextView(frame: .zero)
        descriptionField.font = UIFont.systemFont(ofSize: 16)
        descriptionField.placeholder = "Description"
        descriptionField.placeholderTextColor = UIColor.darkGray
        descriptionField.floatingLabelFont = UIFont.boldSystemFont(ofSize: 11)
        descriptionField.floatingLabelTextColor = floatingLabelColor
        view.addSubview(descriptionField)
        descriptionField.translatesAutoresizingMaskIntoConstraints = false

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(xMargin)-[titleField]-(xMargin)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["xMargin": 10], views: ["titleField": titleField]))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[div1]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["div1": div1]))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(xMargin)-[priceField]-(xMargin)-[div2(1)]-(xMargin)-[locationField]-(xMargin)-|", options: .alignAllCenterY, metrics: ["xMargin": 10], views: ["priceField": priceField, "div2": div2, "locationField": locationField]))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[div3]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["div3": div3]))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(xMargin)-[descriptionField]-(xMargin)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["xMargin": 10], views: ["descriptionField": descriptionField]))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleField(>=minHeight)][div1(1)][priceField(>=minHeight)][div3(1)][descriptionField]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["minHeight": 44], views: ["titleField": titleField, "div1": div1, "priceField": priceField, "div3": div3, "descriptionField": descriptionField]))

        self.view.addConstraint(NSLayoutConstraint(item: priceField, attribute: .height, relatedBy: .equal, toItem: div2, attribute: .height, multiplier: 1.0, constant: 0.0))

        self.view.addConstraint(NSLayoutConstraint(item: priceField, attribute: .height, relatedBy: .equal, toItem: locationField, attribute: .height, multiplier: 1.0, constant: 0.0))
    }
}
