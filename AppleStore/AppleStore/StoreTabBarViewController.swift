//
//  StoreTabBarViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 6.10.22.
//

import UIKit

/// MainTabBarController. Tabs: Shop. For you. Search. Bag.
final class StoreTabBarViewController: UITabBarController {
    // MARK: - Constant
    enum Constant {
        static let shopItemTitle = "Shop"
        static let sessionItemTitle = "Session"
        static let forYouItemTitle = "For You"
        static let searchItemTitle = "Search"
        static let bagItemTitle = "Bag"
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabsAction()
    }
    
    // MARK: - Private Properties
    private func createTabsAction() {
        let firstViewController = ShopViewController()
        let secondViewController = SessionsViewController()
        let thirdViewController = ForYouViewController()
        let forthViewController = SearchViewController()
        let fifthViewController = BagViewController()
        firstViewController.tabBarItem = UITabBarItem(title: Constant.shopItemTitle,
                                                      image: UIImage(systemName: "laptopcomputer.and.iphone"),
                                                      tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: Constant.sessionItemTitle,
                                                       image: UIImage(systemName: "calendar"),
                                                       tag: 1)
        thirdViewController.tabBarItem = UITabBarItem(title: Constant.forYouItemTitle,
                                                      image: UIImage(systemName: "person.circle"),
                                                      tag: 2)
        forthViewController.tabBarItem = UITabBarItem(title: Constant.searchItemTitle,
                                                      image: UIImage(systemName: "magnifyingglass"),
                                                      tag: 3)
        fifthViewController.tabBarItem = UITabBarItem(title: Constant.bagItemTitle,
                                                      image: UIImage(systemName: "bag"),
                                                      tag: 4)
        viewControllers = [
            firstViewController,
            secondViewController,
            thirdViewController,
            forthViewController,
            fifthViewController
        ]
    }
}
