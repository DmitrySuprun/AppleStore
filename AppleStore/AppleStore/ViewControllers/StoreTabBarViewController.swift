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
        static let systemImageLaptopiPhone = "laptopcomputer.and.iphone"
        static let systemImageCalendar = "calendar"
        static let systemImagePerson = "person.circle"
        static let systemImageGlass = "magnifyingglass"
        static let systemImageBag = "bag"
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabsAction()
    }
    
    // MARK: - Private Properties
    private func setupUI() {
        view.backgroundColor = .systemBackground
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
                                                      image: UIImage(systemName: Constants.systemImageLaptopiPhone),
                                                      tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: Constants.sessionItemTitle,
                                                       image: UIImage(systemName: Constants.systemImageCalendar),
                                                       tag: 1)
        thirdViewController.tabBarItem = UITabBarItem(title: Constants.forYouItemTitle,
                                                      image: UIImage(systemName: Constants.systemImagePerson),
                                                      tag: 2)
        forthViewController.tabBarItem = UITabBarItem(title: Constants.searchItemTitle,
                                                      image: UIImage(systemName: Constants.systemImageGlass),
                                                      tag: 3)
        fifthViewController.tabBarItem = UITabBarItem(title: Constants.bagItemTitle,
                                                      image: UIImage(systemName: Constants.systemImageBag),
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
