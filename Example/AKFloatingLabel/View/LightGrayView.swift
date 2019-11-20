//
//  LightGrayView.swift
//  AKFloatingLabel_Example
//
//  Created by Diogo Autilio on 20/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

final class LightGrayView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
