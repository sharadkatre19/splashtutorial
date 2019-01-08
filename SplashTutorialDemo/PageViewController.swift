//
//  PageViewController.swift
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
            Tutorial(tutorialImage: UIImage(named: "dot"), titleText: "Seamless Bookings", descriptionText: "Book a doorstep package delivery in a few simple steps."),
            Tutorial(tutorialImage: UIImage(named: "dot"), titleText: "Real-time Tracking", descriptionText: "Check the real-time status of of your deliveries on a map."),
            Tutorial(tutorialImage: UIImage(named: "dot"), titleText: "Online Payments", descriptionText: "Pay for your deliveries securely from the app itself.")
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

class PageViewController: UIPageViewController {
    
    let customPageControlWidth: CGFloat = 60.0
    let customPageControlHeight: CGFloat = 20.0
    var customPageControl: CustomUIPageControl = CustomUIPageControl()
    let initialPage = 0

    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        setScrollViewDelegate()
        setupPageViewController()
        
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
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return pages.last }
        
        guard pages.count > previousIndex else { return nil }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        
        guard pages.count > nextIndex else { return nil         }
        
        return pages[nextIndex]
    }
    
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.customPageControl.setSeletedPageIndicator(at: viewControllerIndex)
            }
        }
    }
}

extension PageViewController: UIScrollViewDelegate {
    private func setScrollViewDelegate() {
        if let subViews = self.view.subviews as? [UIScrollView] {
            for scrollview in subViews {
                scrollview.delegate = self
            }
        }
    }
}
