//
//  ViewController.swift
//  AKFloatingLabel
//
//  Created by Diogo Autilio on 07/03/2017.
//  Copyright (c) 2017 Diogo Autilio. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    let sampleView = SampleView()

    override func loadView() {
        self.view = sampleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Floating Label Demo"
    }
}
