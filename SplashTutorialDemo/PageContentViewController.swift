//
//  ViewController.swift
//  SplashTutorialDemo
//
//  Created by Sharad Katre on 08/01/19.
//  Copyright © 2019 Sharad Katre. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setTutorialsData(_ tutorialsDataViewModel: Tutorial) {
        self.titleLabel.text = tutorialsDataViewModel.titleText
        self.descriptionLabel.text = tutorialsDataViewModel.descriptionText
        self.imageView.image = tutorialsDataViewModel.tutorialImage
    }
}

