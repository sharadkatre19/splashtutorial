//
//  AppTutorialPageViewController.swift
//  SplashTutorialDemo
//
//  Created by Sharad Katre on 08/01/19.
//  Copyright © 2019 Sharad Katre. All rights reserved.
//

import UIKit

struct Tutorial {
    var tutorialImage: UIImage?
    var titleText: String?
    var descriptionText: String?
}

var viewModel = TutorialViewModel()

struct TutorialViewModel {
    var tutorials: [Tutorial] {
        return [
            Tutorial(tutorialImage: UIImage(named: "tutorial"), titleText: "Seamless Bookings", descriptionText: "Book a doorstep package delivery in a few simple steps."),
            Tutorial(tutorialImage: UIImage(named: "tutorial"), titleText: "Real-time Tracking", descriptionText: "Check the real-time status of of your deliveries on a map."),
            Tutorial(tutorialImage: UIImage(named: "tutorial"), titleText: "Online Payments", descriptionText: "Pay for your deliveries securely from the app itself.")
        ]
    }
    
    lazy var orderedViewControllers: [PageContentViewController] = {
        return newViewControllers()
    }()
    
    func newViewControllers() -> [PageContentViewController] {
        var list = [PageContentViewController]()
        for (_, tutorial) in tutorials.enumerated() {
            let storyborad = UIStoryboard(name: "Main", bundle: nil)
            if let pageContentViewController: PageContentViewController = storyborad.instantiateViewController(withIdentifier: "PageContentViewController") as? PageContentViewController {
                pageContentViewController.loadViewIfNeeded()
                pageContentViewController.setTutorialsData(tutorial)
                list.append(pageContentViewController)
            }
        }
        return list
    }
}

class AppTutorialPageViewController: UIPageViewController {
    
    let customPageControlWidth: CGFloat = 60.0
    let customPageControlHeight: CGFloat = 20.0
    var customPageControl: CustomUIPageControl = CustomUIPageControl()
    let initialPage = 0

    var pages = [UIViewController]()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.signUpButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()

    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.skipButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        setScrollViewDelegate()
        setupPageViewController()
        setupButtons()
        
        self.view.backgroundColor = UIColor.white
        let xOffSet = ((self.view.bounds.width / 2) - (customPageControlWidth / 2))
        customPageControl = CustomUIPageControl(frame: CGRect(x: xOffSet, y: self.view.frame.maxY - 150, width: customPageControlWidth, height: customPageControlHeight))
        customPageControl.numberOfPages = pages.count
        self.view.addSubview(customPageControl)
    }
    
    private func setupPageViewController() {
        self.pages = viewModel.orderedViewControllers
        setViewControllers([self.pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setupButtons() {
        self.view.addSubview(signUpButton)
        self.signUpButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        self.signUpButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20.0).isActive = true
        self.signUpButton.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        self.signUpButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(skipButton)
        self.skipButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        self.skipButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20.0).isActive = true
        self.skipButton.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        self.skipButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        self.skipButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func signUpButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func skipButtonTapped(_ sender: UIButton) {
        print(#function)
    }

}

extension AppTutorialPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            
            if viewControllerIndex == 0 {
                return nil
            } else {
                
                return getViewControllerAtIndex(index: viewControllerIndex - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            
            if viewControllerIndex < self.pages.count - 1 {
                return getViewControllerAtIndex(index: viewControllerIndex + 1)
                
            } else {
                return nil
            }
        }
        return nil
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> PageContentViewController
    {
        if let pageContentViewController: PageContentViewController = self.pages[index] as? PageContentViewController {
            pageContentViewController.setTutorialsData(TutorialViewModel().tutorials[index])
            return pageContentViewController
        }
        return PageContentViewController()
    }
    
}

extension AppTutorialPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.customPageControl.setSeletedPageIndicator(at: viewControllerIndex)
            }
        }
    }
}

extension AppTutorialPageViewController: UIScrollViewDelegate {
    private func setScrollViewDelegate() {
        if let subViews = self.view.subviews as? [UIScrollView] {
            for scrollview in subViews {
                scrollview.delegate = self
            }
        }
    }
}
