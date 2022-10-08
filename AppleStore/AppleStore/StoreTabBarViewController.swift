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
    private enum Constant {
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
        let forthViewController = SearchViewController()
        let navigationController = UINavigationController(rootViewController: forthViewController)
        let fifthViewController = BagViewController()
        firstViewController.tabBarItem = UITabBarItem(title: Constant.shopItemTitle,
                                                      image: UIImage(systemName: Constant.systemImageLaptopiPhone),
                                                      tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: Constant.sessionItemTitle,
                                                       image: UIImage(systemName: Constant.systemImageCalendar),
                                                       tag: 1)
        thirdViewController.tabBarItem = UITabBarItem(title: Constant.forYouItemTitle,
                                                      image: UIImage(systemName: Constant.systemImagePerson),
                                                      tag: 2)
        forthViewController.tabBarItem = UITabBarItem(title: Constant.searchItemTitle,
                                                      image: UIImage(systemName: Constant.systemImageGlass),
                                                      tag: 3)
        fifthViewController.tabBarItem = UITabBarItem(title: Constant.bagItemTitle,
                                                      image: UIImage(systemName: Constant.systemImageGlass),
                                                      tag: 4)
        viewControllers = [
            firstViewController,
            secondViewController,
            thirdViewController,
            navigationController,
            fifthViewController
        ]
    }
}
