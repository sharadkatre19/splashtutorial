//
//  ViewController.swift
//  SplashTutorialDemo
//
//  Created by Sharad Katre on 08/01/19.
//  Copyright © 2019 Sharad Katre. All rights reserved.
//

import UIKit

enum AnimationType {
    case translation
    case scale
    case rotation
}

extension UIView {
    
    func animateView(withAnimationType animationType: AnimationType) {
        
        if animationType == .scale {
            animateViewScale()
        }

        if animationType == .translation {
            animateViewTranslation()
        }

        if animationType == .rotation {
            animateViewRotation()
        }

    }
    
    func animateViewScale() {
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.transform = scale
        UIView.animate(withDuration: 0.7, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    func animateViewTranslation() {
        let translation = CGAffineTransform(translationX: self.frame.minX, y: self.frame.maxY / 2)
        self.transform = translation
        UIView.animate(withDuration: 0.7, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
    }
    
    func animateViewRotation() {
        let rotation = CGAffineTransform(rotationAngle: 360)
        self.transform = rotation
        UIView.animate(withDuration: 0.7, animations: {
            self.transform = CGAffineTransform(rotationAngle: 0)
        }, completion: nil)
    }
}

class PageContentViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateImageView()
    }
    
    func animateImageView() {
        imageView.animateView(withAnimationType: .scale)
        titleLabel.animateView(withAnimationType: .translation)
        descriptionLabel.animateView(withAnimationType: .translation)
    }
    
    func setTutorialsData(_ tutorialsDataViewModel: Tutorial) {
        self.titleLabel.text = tutorialsDataViewModel.titleText
        self.descriptionLabel.text = tutorialsDataViewModel.descriptionText
        self.imageView.image = tutorialsDataViewModel.tutorialImage
    }
}

