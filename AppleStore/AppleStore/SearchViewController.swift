//
//  SearchViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 6.10.22.
//

import UIKit

/// Search products, session, store etc.
final class SearchViewController: UIViewController {
    // MARK: - Constant
    private enum Constants {
        static let emptyString = ""
        static let searchLabelText = "Search"
        static let searchTextFieldPlaceholderText = "What are you looking for?"
        static let recentlyViewedLabelText = "Recently Viewed"
        static let clearButtonTitle = "Clear"
        static let trySearchingLabelText = "Try Searching"
        static let myOrderLabel = "My order status"
        static let shopByLabel = "Shop by appointment"
        static let findAStoreLabel = "Find a store"
        static let systemImageGlass = "magnifyingglass"

        static let caseImageName = "case"
        static let case2ImageName = "case2"
        static let case3ImageName = "case3"
        
        static let bandImageName = "sportBand"
        static let band2ImageName = "clock2"
        
        static let leatherCaseImageName = "caseBrown"
        static let leather2CaseImageName = "caseBrown2"
        static let leather3CaseImageName = "caseBrown3"
        
        static let caseDescription = "Incase Flat mackbook Pro 16\""
        static let bandDescription = "Sport band Black Unity for Apple watch7"
        static let leatherCaseDescription = "Leather Case mackbook Pro 16\""

    }
    
    // MARK: - Private Properties
    private lazy var products = loadProducts()

    private lazy var searchLabel = makeLabel(text: Constants.searchLabelText,
                                             size: 35,
                                             weight: .bold,
                                             xCoordinate: 20,
                                             yCoordinate: 120)
    private lazy var searchBar = makeSearchBar(placeholder: Constants.searchLabelText,
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
    private lazy var firstLabel = makeLabel(text: Constants.caseDescription,
                                            size: 12,
                                            weight: .bold,
                                            xCoordinate: 5,
                                            yCoordinate: 120)
    private lazy var secondLabel = makeLabel(text: Constants.bandDescription,
                                             size: 12,
                                             weight: .bold,
                                             xCoordinate: 10,
                                             yCoordinate: 120)
    private lazy var thirdLabel = makeLabel(text: Constants.leatherCaseDescription,
                                            size: 12,
                                            weight: .bold,
                                            xCoordinate: 5,
                                            yCoordinate: 120)
    private lazy var trySearchingLabel = makeLabel(text: Constants.trySearchingLabelText,
                                                   size: 22,
                                                   weight: .bold,
                                                   xCoordinate: 5,
                                                   yCoordinate: 525)
    private lazy var myOrderLabel = makeLabel(text: Constants.myOrderLabel,
                                              size: 20,
                                              weight: .light,
                                              xCoordinate: 60, yCoordinate: 575)
    private lazy var shopByLabel = makeLabel(text: Constants.shopByLabel,
                                             size: 20,
                                             weight: .light,
                                             xCoordinate: 60, yCoordinate: 625)
    private lazy var findAStore = makeLabel(text: Constants.findAStoreLabel,
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
        title = "Search"
        view.backgroundColor = .systemBackground
        addViews()
    }
    
    private func addViews() {
        view.addSubview(searchLabel)
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
        view.addSubview(makeMagnifyingGlass(yCoordinate: 628))
        view.addSubview(makeMagnifyingGlass(yCoordinate: 678))
    }
    
    private func loadProducts() -> [Product] {
        [Product(name: Constants.emptyString,
                                imagesName: [
                                    Constants.caseImageName,
                                    Constants.case2ImageName,
                                    Constants.case3ImageName
                                ],
                                description: Constants.caseDescription,
                                price: 99),
                        Product(name: Constants.emptyString,
                                imagesName: [
                                    Constants.bandImageName,
                                    Constants.band2ImageName
                                ],
                                description: Constants.bandDescription,
                                price: 29),
                        Product(name: Constants.emptyString,
                                imagesName: [
                                    Constants.leatherCaseImageName,
                                    Constants.leather2CaseImageName,
                                    Constants.leather3CaseImageName
                                ],
                                description: Constants.leatherCaseDescription,
                                price: 79)
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
        imageView.image = UIImage(systemName: Constants.systemImageGlass)
        imageView.tintColor = .label
        imageView.frame = CGRect(x: 20, y: yCoordinate, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }
}
