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
        static let isFirstStartKey = "isFirstStart"
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkFirstStart()
    }
    
    // MARK: - Objc Private Methods
    @objc private func skipActon() {
        let nextViewController = StoreTabBarViewController()
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
    
    @objc private func nextAction() {
        guard let currentViewController = viewControllers?.first else { return }
        guard
            let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController)
        else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true)
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
        }
        
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = .systemGray
        proxy.currentPageIndicatorTintColor = .systemBlue
    }
    
    private func addViews() {
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        view.addSubview(getStarted)
    }
    
    private func checkIndex() {
        for subview in self.view.subviews where subview is UIPageControl {
            subview.isHidden = true
            getStarted.isHidden = false
            nextButton.isHidden = true
            skipButton.isHidden = true
        }
    }
    
    private func checkFirstStart() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: Constants.isFirstStartKey) == false {
            let nextViewController = StoreTabBarViewController()
            nextViewController.modalPresentationStyle = .fullScreen
            present(nextViewController, animated: true)
        }
        userDefaults.set(false, forKey: Constants.isFirstStartKey)
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingItemViewController else { return nil }
        if let index = pagesViewControllers.firstIndex(of: viewController) {
            print(index)
            if index > 0 {
                for subview in self.view.subviews where subview is UIPageControl {
                    subview.isHidden = false
                    getStarted.isHidden = true
                    nextButton.isHidden = false
                    skipButton.isHidden = false
                }
                return pagesViewControllers[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingItemViewController else { return nil }
        if let index = pagesViewControllers.firstIndex(of: viewController) {
            print(index)
            if index == pagesViewControllers.count - 1 {
                for subview in self.view.subviews where subview is UIPageControl {
                    subview.isHidden = true
                    getStarted.isHidden = false
                    nextButton.isHidden = true
                    skipButton.isHidden = true
                }
            }
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
