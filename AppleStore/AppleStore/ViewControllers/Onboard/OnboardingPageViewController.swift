//
//  OnboardingPageViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 12.10.22.
//

import UIKit
/// Onboarding greeting
final class OnboardingPageViewController: UIPageViewController {
    // MARK: - Constants
    private enum Constants {
        static let pageOneImageName = "page1"
        static let pageOneHeaderLabelText = "Track Your Cycle"
        static let pageOneGreetingLabelText = "Manage irregular period and learn how to improve your period"
        static let pageTwoImageName = "page2"
        static let pageTwoHeaderLabelText = "Plan Your Pregnancy"
        static let pageTwoGreetingLabelText =
        "Favorable days are important. Vestibulum rutrum quam vitae fringila tincidunt"
        static let pageThreeImageName = "page3"
        static let pageThreeHeaderLabelText = "Daily Health Insight"
        static let pageThreeGreetingLabelText =
        "Personal health insight. Vestibulum rutrum quam vitae fringila tincidunt"
        static let skipButtonTitle = "SKIP"
        static let nextButtonTitle = "NEXT"
        static let getStartedButtonTitle = "GET STARTED"
        static let fatalErrorText = "init(coder:) has not been implemented"
    }
    
    // MARK: - Private Visual Components
    private let pagesViewControllers = [OnboardingItemViewController(imageName: Constants.pageOneImageName,
                                                             headerLabelText: Constants.pageOneHeaderLabelText,
                                                             greetingLabelText: Constants.pageOneGreetingLabelText),
                                OnboardingItemViewController(imageName: Constants.pageTwoImageName,
                                                             headerLabelText: Constants.pageTwoHeaderLabelText,
                                                             greetingLabelText: Constants.pageTwoGreetingLabelText),
                                OnboardingItemViewController(imageName: Constants.pageThreeImageName,
                                                             headerLabelText: Constants.pageThreeHeaderLabelText,
                                                             greetingLabelText: Constants.pageThreeGreetingLabelText)]
    private lazy var skipButton = {
        let button = UIButton(configuration: .borderless())
        button.frame = CGRect(x: 20, y: 790, width: 90, height: 25)
        button.setTitle(Constants.skipButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(skipActon), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton = {
        let button = UIButton(configuration: .borderless())
        button.frame = CGRect(x: 300, y: 790, width: 90, height: 25)
        button.setTitle(Constants.nextButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var getStarted = {
        let button = UIButton(configuration: .borderless())
        button.frame = CGRect(x: 130, y: 790, width: 150, height: 25)
        button.setTitle(Constants.getStartedButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(skipActon), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    // MARK: - Private Properties
    private var pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingPageViewController.self])
    
    // MARK: - Initializers
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Objc Private Methods
    @objc private func skipActon() {
        let nextViewController = StoreTabBarViewController()
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
    
    @objc private func nextAction() {
        guard let currentViewController = viewControllers?.first,
              let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController)
        else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true)
        guard var pageControl = view.subviews.first(where: { $0 is UIPageControl }) as? UIPageControl
        else { return }
        pageControl.currentPage += 1
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        addViews()
        if let rootViewController = pagesViewControllers.first {
            setViewControllers([rootViewController],
                               direction: .forward,
                               animated: true)
            dataSource = self
            delegate = self
        }
        
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .systemBlue
    }
    
    private func addViews() {
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        view.addSubview(getStarted)
    }
    
    private func checkIndex() {
        for subview in view.subviews where subview is UIPageControl {
            subview.isHidden = true
            getStarted.isHidden = false
            nextButton.isHidden = true
            skipButton.isHidden = true
        }
    }
}
// MARK: - UIPageViewControllerDelegate
extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed && viewControllers?.first === pagesViewControllers.last {
            for subview in view.subviews where subview is UIPageControl {
                subview.isHidden = true
                getStarted.isHidden = false
                nextButton.isHidden = true
                skipButton.isHidden = true
            }
        } else {
            for subview in view.subviews where subview is UIPageControl {
                subview.isHidden = false
                getStarted.isHidden = true
                nextButton.isHidden = false
                skipButton.isHidden = false
            }
        }
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingItemViewController else { return nil }
        if let index = pagesViewControllers.firstIndex(of: viewController) {
            if index > 0 {
                return pagesViewControllers[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingItemViewController else { return nil }
        if let index = pagesViewControllers.firstIndex(of: viewController) {
            if index < pagesViewControllers.count - 1 {
                return pagesViewControllers[index + 1]
            }
        }
        return nil
    }
        
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pagesViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}
