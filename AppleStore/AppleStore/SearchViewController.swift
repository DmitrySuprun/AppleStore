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
        static let searchLabelText = "Search"
        static let searchTextFieldPlaceholderText = "What are you looking for?"
        static let recentlyViewedLabelText = "Recently Viewed"
        static let clearButtonTitle = "Clear"
        static let trySearchingLabelText = "Try Searching"
        static let myOrderLabel = "My order status"
        static let shopByLabel = "Shop by appointment"
        static let findAStoreLabel = "Find a store"
    }
    
    // MARK: - Private Properties
    private lazy var searchLabel = makeLabel(text: Constants.searchLabelText,
                                             size: 35,
                                             weight: .bold,
                                             xCoordinate: 20,
                                             yCoordinate: 120)
    private lazy var searchBar = makeSearchBar(placeholder: Constants.searchLabelText,
                                               xCoordinate: 10,
                                               yCoordinate: 170)
    private lazy var recentlyViewedLabel = makeLabel(text: Constants.recentlyViewedLabelText,
                                                     size: 20,
                                                     weight: .bold,
                                                     xCoordinate: 20,
                                                     yCoordinate: 220)
    private lazy var clearButton = makeButton(title: Constants.clearButtonTitle,
                                              xCoordinate: 325,
                                              yCoordinate: 215)
    private lazy var firstView = makeView(xCoordinate: 20, yCoordinate: 260, tag: 0)
    private lazy var secondView = makeView(xCoordinate: 180, yCoordinate: 260, tag: 1)
    private lazy var thirdView = makeView(xCoordinate: 340, yCoordinate: 260, tag: 2)
    private lazy var firstImageView = makeImageView(name: "Iphone14pro")
    private lazy var secondImageView = makeImageView(name: "WatchUltra")
    private lazy var thirdImageView = makeImageView(name: "Airpods3gen")
    private lazy var firstLabel = makeLabel(text: "Iphone 14pro",
                                            size: 15,
                                            weight: .light,
                                            xCoordinate: 10,
                                            yCoordinate: 135)
    private lazy var secondLabel = makeLabel(text: "Watch Ultra",
                                             size: 15,
                                             weight: .light,
                                             xCoordinate: 10,
                                             yCoordinate: 135)
    private lazy var thirdLabel = makeLabel(text: "Airpods",
                                            size: 15,
                                            weight: .light,
                                            xCoordinate: 10,
                                            yCoordinate: 135)
    private lazy var trySearchingLabel = makeLabel(text: Constants.trySearchingLabelText,
                                                   size: 20,
                                                   weight: .bold,
                                                   xCoordinate: 20,
                                                   yCoordinate: 480)
    private lazy var myOrderLabel = makeLabel(text: Constants.myOrderLabel,
                                              size: 20,
                                              weight: .light,
                                              xCoordinate: 60, yCoordinate: 520)
    private lazy var shopByLabel = makeLabel(text: Constants.shopByLabel,
                                             size: 20,
                                             weight: .light,
                                             xCoordinate: 60, yCoordinate: 560)
    private lazy var findAStore = makeLabel(text: Constants.findAStoreLabel,
                                            size: 20,
                                            weight: .light,
                                            xCoordinate: 60,
                                            yCoordinate: 600)

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Objc Methods
    @objc private func pushProductInfoAction(_ sender: UITapGestureRecognizer) {
        var image = ""
        var name = ""
        switch sender.view?.tag {
        case 0:
            image = "Iphone14pro"
            name = "Iphone 14pro"
        case 1:
            image = "WatchUltra"
            name = "Watch Ultra"
        case 2:
            image = "Airpods3gen"
            name = "Airpods"
        default: break
        }
        let nextViewController = ImageInfoViewController()
        nextViewController.productImage = image
        nextViewController.productName = name
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        addViews()
    }
    
    private func addViews() {
        view.addSubview(searchLabel)
        view.addSubview(searchBar)
        view.addSubview(recentlyViewedLabel)
        view.addSubview(clearButton)
        view.addSubview(firstView)
        view.addSubview(secondView)
        view.addSubview(thirdView)
        firstView.addSubview(firstImageView)
        firstView.addSubview(firstLabel)
        secondView.addSubview(secondImageView)
        secondView.addSubview(secondLabel)
        thirdView.addSubview(thirdImageView)
        thirdView.addSubview(thirdLabel)
        view.addSubview(trySearchingLabel)
        view.addSubview(myOrderLabel)
        view.addSubview(shopByLabel)
        view.addSubview(findAStore)
        view.addSubview(makeMagnifyingGlass(yCoordinate: 523))
        view.addSubview(makeMagnifyingGlass(yCoordinate: 563))
        view.addSubview(makeMagnifyingGlass(yCoordinate: 603))
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
        label.sizeToFit()
        return label
    }
    
    func makeSearchBar(placeholder: String, xCoordinate: Int, yCoordinate: Int) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = placeholder
        searchBar.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 370, height: 30)
        return searchBar
    }
    
    func makeTextField(placeholder: String, xCoordinate: Int, yCoordinate: Int) -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 360, height: 25)
        textField.placeholder = placeholder
        textField.backgroundColor = .systemGray6
        textField.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        textField.leftViewMode = .always
        textField.rightView = UIImageView(image: UIImage(systemName: "mic.fill"))
        textField.rightViewMode = .always
        return textField
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
        view.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 140, height: 180)
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.backgroundColor = .systemBackground
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(pushProductInfoAction(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        view.isUserInteractionEnabled = true
        return view
    }
    
    func makeImageView(name: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: name))
        imageView.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeMagnifyingGlass(yCoordinate: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .label
        imageView.frame = CGRect(x: 20, y: yCoordinate, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
