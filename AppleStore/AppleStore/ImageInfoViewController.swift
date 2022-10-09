//
//  ImageInfoViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 6.10.22.
//

import UIKit

/// Information about current product
final class ImageInfoViewController: UIViewController {
    // MARK: - Constants
    enum Constant {
        static let emptyText = ""
        static let currencyChar = "$"
        static let systemImageCheckmark = "checkmark.circle.fill"
        static let systemImageHeart = "heart"
        static let systemImageSquare = "square.and.arrow.up"
        static let systemImageShippingBox = "shippingbox"
        static let compatibilityLabelText = "Compatible with MacBook Pro - Evgeny"
        static let addToBagButtonTitle = "Add to Bag"
        static let orderLabelText = """
                                    Order today during the day,  delivery:
                                    Thu 25 Feb - Free
                                    Delivery options for location: 115533
                                    """
    }
    
    // MARK: - Public Properties
    var products: [Product] = []
    var currentProductIndex = 0
    
    // MARK: - Private Properties
    
    private lazy var productLabel = makeLabel(text: products[currentProductIndex].description,
                                              size: 16,
                                              weight: .bold,
                                              xCoordinate: 0,
                                              yCoordinate: 125)
    
    private lazy var productPrice = makeLabel(text: "\(products[currentProductIndex].price) \(Constant.currencyChar)",
                                              size: 16,
                                              weight: .thin,
                                              xCoordinate: 0,
                                              yCoordinate: 150)
    private lazy var productImagesScrollView = makeScrollView()
    private lazy var productSmallLabel = makeLabel(text: products[currentProductIndex].description,
                                                   size: 11,
                                                   weight: .light,
                                                   xCoordinate: 0,
                                                   yCoordinate: 470)
    private lazy var compatibilityLabel = makeLabel(text: Constant.compatibilityLabelText,
                                                    size: 11,
                                                    weight: .light,
                                                    xCoordinate: 0,
                                                    yCoordinate: 620)
    private lazy var firstColorButton = makeRoundButton(xCoordinate: 145)
    private lazy var secondColorButton = makeRoundButton(xCoordinate: 205)
    private lazy var addToBagButton = makeButton()
    private lazy var orderInfoLabel = makeLabel(text: Constant.orderLabelText,
                                                size: 11,
                                                weight: .bold,
                                                xCoordinate: 0,
                                                yCoordinate: 750)
    private lazy var pageScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.maxX, height: view.bounds.maxY)
        scrollView.contentInset = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
        return scrollView
    }()
    
    private lazy var checkMarkImageView = {
        let imageView = UIImageView(image: UIImage(systemName: Constant.systemImageCheckmark))
        imageView.frame = CGRect(x: 60, y: 615, width: 20, height: 20)
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    private lazy var boxImageView = {
        let imageView = UIImageView(image: UIImage(systemName: Constant.systemImageShippingBox))
        imageView.frame = CGRect(x: 20, y: 750, width: 20, height: 20)
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private lazy var barButtonItems = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: Constant.systemImageHeart))
        let barButtonItem2 = UIBarButtonItem(image: UIImage(systemName: Constant.systemImageSquare))
        return [barButtonItem, barButtonItem2]
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - @Objc Private Methods
    @objc private func toggleShadowButtonAction(_ sender: UIButton) {
        firstColorButton.layer.shadowRadius = sender === firstColorButton ? 3 : 0
        secondColorButton.layer.shadowRadius = sender === secondColorButton ? 3 : 0
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItems = barButtonItems
        addViews()
        productLabel.center.x = view.center.x
        productPrice.center.x = view.center.x
        productSmallLabel.center.x = view.center.x
        compatibilityLabel.center.x = view.center.x
        orderInfoLabel.center.x = view.center.x
        orderInfoLabel.center.x -= 35
        orderInfoLabel.numberOfLines = 3
        orderInfoLabel.sizeToFit()
        addAttributedTextAction()
    }
    
    private func addViews() {
        view.addSubview(pageScrollView)
        pageScrollView.addSubview(productLabel)
        pageScrollView.addSubview(productPrice)
        pageScrollView.addSubview(productImagesScrollView)
        addViewToScrollView()
        pageScrollView.addSubview(productSmallLabel)
        pageScrollView.addSubview(compatibilityLabel)
        pageScrollView.addSubview(firstColorButton)
        pageScrollView.addSubview(secondColorButton)
        secondColorButton.layer.shadowRadius = 3
        addGradientAction(button: secondColorButton)
        pageScrollView.addSubview(addToBagButton)
        pageScrollView.addSubview(orderInfoLabel)
        pageScrollView.addSubview(checkMarkImageView)
        pageScrollView.addSubview(boxImageView)
    }
    
    private func addAttributedTextAction() {
        var attributedString = NSMutableAttributedString(string: Constant.compatibilityLabelText)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue],
                                       range: NSRange(location: 16, length: 20))
        compatibilityLabel.attributedText = attributedString
        attributedString = NSMutableAttributedString(string: Constant.orderLabelText)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray],
                                       range: NSRange(location: 39, length: 17))
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue],
                                       range: NSRange(location: 56, length: 38))
        orderInfoLabel.attributedText = attributedString
    }
    
    private func addGradientAction(button: UIButton) {
        let colorTop = UIColor.systemGray5.cgColor
        let colorBottom = UIColor.systemGray3.cgColor
        let layer = CAGradientLayer()
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.colors = [colorTop, colorBottom]
        layer.locations = [0.0, 1.0]
        layer.frame = button.bounds
        button.layer.insertSublayer(layer, at: 0)
        var config = button.configuration
        config?.background.backgroundColor = .clear
        button.configuration = config
    }
    
    private func addViewToScrollView() {
        var xCoordinate = 0
        for item in products[currentProductIndex].imagesName {
            let imageView = makeImageView(image: item)
            imageView.frame = CGRect(x: xCoordinate, y: 0, width: 393, height: 180)
            productImagesScrollView.addSubview(imageView)
            xCoordinate += 393
        }
        let maxXContentSizeProductsScrollView = productImagesScrollView.subviews.map { $0.frame.maxX }.max()
        productImagesScrollView.contentSize = CGSize(width: maxXContentSizeProductsScrollView ?? 0, height: 200)
    }
}

// MARK: - Factory
extension ImageInfoViewController {
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
    
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.frame = CGRect(x: 0, y: 230, width: 393, height: 225)
        return scrollView
    }
    
    func makeImageView(image: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: image))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeRoundButton(xCoordinate: Int) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.borderless()
        config.cornerStyle = .capsule
        config.background.strokeColor = .systemBackground
        config.background.strokeWidth = 3
        config.background.backgroundColor = .systemGray
        button.configuration = config
        button.frame = CGRect(x: xCoordinate, y: 550, width: 40, height: 40)
        button.backgroundColor = .clear
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowColor = UIColor.systemBlue.cgColor
        button.layer.shadowRadius = 0
        button.layer.shadowOpacity = 1
        button.addTarget(self, action: #selector(toggleShadowButtonAction(_:)), for: .touchUpInside)
        return button
    }
    
    func makeButton() -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = Constant.addToBagButtonTitle
        button.frame = CGRect(x: 10, y: 670, width: 373, height: 40)
        button.configuration = config
        return button
    }
}
