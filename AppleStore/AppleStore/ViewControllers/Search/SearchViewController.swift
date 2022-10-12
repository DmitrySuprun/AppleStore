//
//  SearchViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 6.10.22.
//

import UIKit

/// Search products, session, store etc.
final class SearchViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let emptyName = ""
        static let title = "Search"
        static let searchTextFieldPlaceholder = "What are you looking for?"
        static let recentlyViewedLabelText = "Recently Viewed"
        static let clearButtonTitle = "Clear"
        static let trySearchingLabelText = "Try Searching"
        static let myOrderLabelText = "My order status"
        static let shopByLabelText = "Shop by appointment"
        static let findAStoreLabelText = "Find a store"
        static let systemImageGlassName = "magnifyingglass"
        
        static let caseImageName = "case"
        static let case2ImageName = "case2"
        static let case3ImageName = "case3"
        
        static let bandImageName = "sportBand"
        static let band2ImageName = "clock2"
        
        static let leatherCaseImageName = "caseBrown"
        static let leather2CaseImageName = "caseBrown2"
        static let leather3CaseImageName = "caseBrown3"
        
        static let caseDescriptionLabelText = "Incase Flat mackbook Pro 16\""
        static let bandDescriptionLabelText = "Sport band Black Unity for Apple watch7"
        static let leatherCaseDescriptionLabelText = "Leather Case mackbook Pro 16\""
        
        static let caseURLName = "https://www.apple.com/shop/product/HQ292ZM/A/incase-compact-sleeve-in-flight-nylon-for-16-macbook-pro?fnode=8941b688caeb9f1a13ebc4d425b079bd374bc2e03b5f6682b263ef1f6f9132be58ac8c71ebd4e97dd1e41d4cfc6bbd5cf68e50751cfc425761043e83923f6fc1013200a6e44740654e4d6d13a8ff0fcacd7ff8c32b8c29dd04daf61c9d9b8910"
        static let bandURLName = "https://www.apple.com/shop/product/MJ4V3AM/A/40mm-black-unity-sport-band-regular?fnode=2bf27ab6d3c607e280709c340399991a3610ba2adedde34df3d3fcfe787809255fe7c857604fc06e424ad4798cd4fcd61a53a0a250fbcb3a6c6220c28048d2ac7de3afd8b73a69ba746b48dfa4083e2e"
        static let leatherURLName = "https://www.apple.com/shop/product/HPZR2ZM/A/von-holzhausen-macbook-16-portfolio?fnode=fe63877cbbf64adb82fd4531dfc4f59c6fcf5a357960bf89dcc83b47f6c8eb5f41fdfe8e8df69c3f8fb2d07ea7770bfe94818396157082f2a1bcab0179a35a53d183153a6a87b53d605f44ff26c886ea6858aa11b77ed2846baa71eb0fa7aafc"
    }
    
    // MARK: - Private Properties
    private lazy var products = loadProducts()
    
    private lazy var searchBar = makeSearchBar(placeholder: Constants.title,
                                               xCoordinate: 5,
                                               yCoordinate: 170)
    private lazy var recentlyViewedLabel = makeLabel(text: Constants.recentlyViewedLabelText,
                                                     size: 20,
                                                     weight: .bold,
                                                     xCoordinate: 20,
                                                     yCoordinate: 250)
    private lazy var clearButton = makeButton(title: Constants.clearButtonTitle,
                                              xCoordinate: 325,
                                              yCoordinate: 245)
    private lazy var productsScrollView = makeScrollView()
    private lazy var firstView = makeView(xCoordinate: 10, yCoordinate: 5, tag: 0)
    private lazy var secondView = makeView(xCoordinate: 160, yCoordinate: 5, tag: 1)
    private lazy var thirdView = makeView(xCoordinate: 310, yCoordinate: 5, tag: 2)
    private lazy var firstImageView = makeImageView(name: Constants.caseImageName)
    private lazy var secondImageView = makeImageView(name: Constants.bandImageName)
    private lazy var thirdImageView = makeImageView(name: Constants.leatherCaseImageName)
    private lazy var firstLabel = makeLabel(text: Constants.caseDescriptionLabelText,
                                            size: 12,
                                            weight: .bold,
                                            xCoordinate: 5,
                                            yCoordinate: 120)
    private lazy var secondLabel = makeLabel(text: Constants.bandDescriptionLabelText,
                                             size: 12,
                                             weight: .bold,
                                             xCoordinate: 10,
                                             yCoordinate: 120)
    private lazy var thirdLabel = makeLabel(text: Constants.leatherCaseDescriptionLabelText,
                                            size: 12,
                                            weight: .bold,
                                            xCoordinate: 5,
                                            yCoordinate: 120)
    private lazy var trySearchingLabel = makeLabel(text: Constants.trySearchingLabelText,
                                                   size: 22,
                                                   weight: .bold,
                                                   xCoordinate: 20,
                                                   yCoordinate: 525)
    private lazy var myOrderLabel = makeLabel(text: Constants.myOrderLabelText,
                                              size: 20,
                                              weight: .light,
                                              xCoordinate: 60, yCoordinate: 575)
    private lazy var shopByLabel = makeLabel(text: Constants.shopByLabelText,
                                             size: 20,
                                             weight: .light,
                                             xCoordinate: 60, yCoordinate: 625)
    private lazy var findAStore = makeLabel(text: Constants.findAStoreLabelText,
                                            size: 20,
                                            weight: .light,
                                            xCoordinate: 60,
                                            yCoordinate: 675)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Objc Methods
    @objc private func pushProductInfoAction(_ sender: UITapGestureRecognizer) {
        let nextViewController = ImageInfoViewController()
        nextViewController.currentProductIndex = sender.view?.tag ?? 0
        nextViewController.products = products
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        title = Constants.title
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        addViews()
    }
    
    private func addViews() {
        view.addSubview(searchBar)
        view.addSubview(recentlyViewedLabel)
        view.addSubview(clearButton)
        view.addSubview(productsScrollView)
        
        productsScrollView.addSubview(firstView)
        productsScrollView.addSubview(secondView)
        productsScrollView.addSubview(thirdView)
        let maxXContentSizeProductsScrollView = productsScrollView.subviews.map { $0.frame.maxX }.max()
        productsScrollView.contentSize = CGSize(width: maxXContentSizeProductsScrollView ?? 0, height: 190)
        
        firstView.addSubview(firstImageView)
        firstView.addSubview(firstLabel)
        firstLabel.frame.size = CGSize(width: 120, height: 50)
        secondView.addSubview(secondImageView)
        secondView.addSubview(secondLabel)
        secondLabel.frame.size = CGSize(width: 120, height: 50)
        thirdView.addSubview(thirdImageView)
        thirdView.addSubview(thirdLabel)
        thirdLabel.frame.size = CGSize(width: 120, height: 50)
        
        view.addSubview(trySearchingLabel)
        view.addSubview(myOrderLabel)
        view.addSubview(shopByLabel)
        view.addSubview(findAStore)
        view.addSubview(makeMagnifyingGlass(yCoordinate: 578))
        view.addSubview(makeLineView(yCoordinate: 605))
        view.addSubview(makeMagnifyingGlass(yCoordinate: 628))
        view.addSubview(makeLineView(yCoordinate: 655))
        view.addSubview(makeMagnifyingGlass(yCoordinate: 678))
        view.addSubview(makeLineView(yCoordinate: 705))
        
    }
    
    private func loadProducts() -> [Product] {
        [Product(name: Constants.emptyName,
                 imagesNames: [
                    Constants.caseImageName,
                    Constants.case2ImageName,
                    Constants.case3ImageName
                 ],
                 description: Constants.caseDescriptionLabelText,
                 price: 99,
                 urlName: Constants.caseURLName),
         Product(name: Constants.emptyName,
                 imagesNames: [
                    Constants.bandImageName,
                    Constants.band2ImageName
                 ],
                 description: Constants.bandDescriptionLabelText,
                 price: 29,
                 urlName: Constants.bandURLName),
         Product(name: Constants.emptyName,
                 imagesNames: [
                    Constants.leatherCaseImageName,
                    Constants.leather2CaseImageName,
                    Constants.leather3CaseImageName
                 ],
                 description: Constants.leatherCaseDescriptionLabelText,
                 price: 79, urlName: Constants.leatherURLName)
        ]
    }
}

// MARK: - Factory
private extension SearchViewController {
    func makeLabel(text: String,
                   size: CGFloat,
                   weight: UIFont.Weight,
                   xCoordinate: Int,
                   yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.text = text
        label.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 0, height: 0)
        label.numberOfLines = 3
        label.sizeToFit()
        return label
    }
    
    func makeSearchBar(placeholder: String, xCoordinate: Int, yCoordinate: Int) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = placeholder
        searchBar.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 383, height: 35)
        searchBar.searchBarStyle = .minimal
        return searchBar
    }
    
    func makeButton(title: String, xCoordinate: Int, yCoordinate: Int) -> UIButton {
        let button = UIButton(configuration: .plain())
        button.setTitle(title, for: .normal)
        button.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 100, height: 50)
        button.sizeToFit()
        return button
    }
    
    func makeView(xCoordinate: Int, yCoordinate: Int, tag: Int) -> UIView {
        let view = UIView()
        view.tag = tag
        view.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 135, height: 180)
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray6
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(pushProductInfoAction(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        view.isUserInteractionEnabled = true
        return view
    }
    
    func makeImageView(name: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: name))
        imageView.frame = CGRect(x: 20, y: 20, width: 95, height: 95)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 290, width: 393, height: 190)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    func makeMagnifyingGlass(yCoordinate: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.systemImageGlassName)
        imageView.tintColor = .label
        imageView.frame = CGRect(x: 20, y: yCoordinate, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }
    
    private func makeLineView(yCoordinate: CGFloat) -> UIView {
        let line = UIView()
        line.backgroundColor = .systemGray6
        line.frame = CGRect(x: 15, y: yCoordinate, width: view.frame.width - 30, height: 2)
        return line
    }
}
