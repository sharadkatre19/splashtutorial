//
//  CustomUIPageControl.swift
//  SplashTutorialDemo
//
//  Created by Sharad Katre on 08/01/19.
//  Copyright © 2019 Sharad Katre. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomUIPageControl: UIView {
    
    @IBInspectable
    var numberOfPages: Int = 3 {
        didSet {
            prepareForUI()
        }
    }
    
    @IBInspectable
    var selectedPage: Int = 0 {
        didSet {
            prepareForUI()
        }
    }
    
    var indicatorTintColor = UIColor.black
    var deSelectedTintColor = UIColor.lightGray

    var imageViewList: [UIImageView] = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareForUI()
    }
    
    override func prepareForInterfaceBuilder() {
        prepareForUI()
    }
    
    func setSeletedPageIndicator(at pageNumber: Int) {
        if pageNumber >= numberOfPages {
            assertionFailure("Out of Page Index")
        }
        self.selectedPage = pageNumber
        prepareForUI()
    }

}

extension CustomUIPageControl {
    func prepareForUI() {
        imageViewList.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        for page in 0..<(numberOfPages) {
            let imageView = UIImageView()
            imageView.tag = page
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "dot")
            if selectedPage == page {
                imageView.image = UIImage(named: "selected")
            }
            imageView.clipsToBounds = true
            imageViewList.append(imageView)
        }
        let stackView = UIStackView(arrangedSubviews: imageViewList)
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 5.0
        self.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
}
