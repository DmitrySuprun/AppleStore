//
//  StoreTabBarViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 6.10.22.
//

import UIKit

/// MainTabBarController. Tabs: Shop. For you. Search. Bag.
final class StoreTabBarViewController: UITabBarController {
    // MARK: - Constants
    private enum Constants {
        static let shopItemTitle = "Shop"
        static let sessionItemTitle = "Session"
        static let forYouItemTitle = "For You"
        static let searchItemTitle = "Search"
        static let bagItemTitle = "Bag"
        static let laptopiPhoneSystemImageName = "laptopcomputer.and.iphone"
        static let calendarSystemImageName = "calendar"
        static let personSystemImageName = "person.circle"
        static let glassSystemImageName = "magnifyingglass"
        static let bagSystemImageName = "bag"
        static let isFirstStartKey = "isFirstStart"
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabsAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkFirstStart()
    }
    
    // MARK: - Private Properties
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func checkFirstStart() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: Constants.isFirstStartKey) == true {
            let nextViewController = OnboardingPageViewController()
            nextViewController.modalPresentationStyle = .fullScreen
            present(nextViewController, animated: true)
        }
        userDefaults.set(false, forKey: Constants.isFirstStartKey)
    }
    
    private func createTabsAction() {
        let firstViewController = ShopViewController()
        let secondViewController = SessionsViewController()
        let thirdViewController = ForYouViewController()
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController)
        let forthViewController = SearchViewController()
        let forthNavigationController = UINavigationController(rootViewController: forthViewController)
        let fifthViewController = BagViewController()
        firstViewController.tabBarItem = UITabBarItem(title: Constants.shopItemTitle,
                                                      image: UIImage(systemName: Constants.laptopiPhoneSystemImageName),
                                                      tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: Constants.sessionItemTitle,
                                                       image: UIImage(systemName: Constants.calendarSystemImageName),
                                                       tag: 1)
        thirdViewController.tabBarItem = UITabBarItem(title: Constants.forYouItemTitle,
                                                      image: UIImage(systemName: Constants.personSystemImageName),
                                                      tag: 2)
        forthViewController.tabBarItem = UITabBarItem(title: Constants.searchItemTitle,
                                                      image: UIImage(systemName: Constants.glassSystemImageName),
                                                      tag: 3)
        fifthViewController.tabBarItem = UITabBarItem(title: Constants.bagItemTitle,
                                                      image: UIImage(systemName: Constants.bagSystemImageName),
                                                      tag: 4)
        viewControllers = [
            firstViewController,
            secondViewController,
            thirdNavigationController,
            forthNavigationController,
            fifthViewController
        ]
    }
}
