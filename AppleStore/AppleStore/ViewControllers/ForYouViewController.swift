//
//  ForYouViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 6.10.22.
//

import UIKit

/// Personal recommendation.
final class ForYouViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let title = "For You"
        static let emptyName = ""
        static let hereLabelText = "Here's what's happening "
        static let suggestedLabelText = "Suggested for you"
        static let orderLabelText = "Get news about your order in real time"
        static let orderLightLabelText = "Turn on notifications to receive news about your order"
        static let rightChevronSystemImageName = "chevron.right"
        static let appBadgeSystemImageName = "app.badge"
        static let airpodsImageName = "apple-airpod"
        static let sendLabelText = "Your order has been sent"
        static let countLabelText = "1 item shipping tomorrow"
        static let processedLabelText = "Processed"
        static let sentLabelText = "sent"
        static let deliveredLabelText = "delivered"
        static let avatarKey = "avatar"
        static let recommendedLabelText = "Recommended for your devices"
        static let seeAllLabelText = "See all"
    }
    
    // MARK: - Private Properties
    private var currentUserInterfaceStyle: UIUserInterfaceStyle = .light
    private lazy var avatarImageView = makeAvatarImageView()
    private lazy var productsScrollView = makeScrollView()
    private lazy var hereLabel = makeLabel(text: Constants.hereLabelText,
                                           size: 27,
                                           xCoordinate: 20,
                                           yCoordinate: 170)
    private lazy var suggestedLabel = makeLabel(text: Constants.suggestedLabelText,
                                                size: 24,
                                                xCoordinate: 20,
                                                yCoordinate: 450)
    private lazy var orderLabel = makeLabel(text: Constants.orderLabelText,
                                            size: 15,
                                            frame: CGRect(x: 130, y: 510, width: 170, height: 50))
    private lazy var orderLightLabel = makeLabel(text: Constants.orderLightLabelText,
                                                 size: 15,
                                                 weight: .light,
                                                 frame: CGRect(x: 130, y: 550, width: 200, height: 60))
    private lazy var badgeImageView = makeImageView(systemName: Constants.appBadgeSystemImageName,
                                                    tintColor: .systemRed,
                                                    frame: CGRect(x: 40, y: 515, width: 40, height: 40))
    private lazy var rightChevronImageView = makeImageView(systemName: Constants.rightChevronSystemImageName,
                                                           frame: CGRect(x: 359, y: 550, width: 15, height: 15))
    private lazy var topLineView = makeLineView(yCoordinate: 145)
    private lazy var bottomLineView = makeLineView(yCoordinate: 630)
    private lazy var productView = makeProductView()
    private lazy var middleLineView = makeLineView(frame: CGRect(x: 0, y: 85, width: 353, height: 2))
    private lazy var airpodsImageView = makeImageView(named: Constants.airpodsImageName,
                                                      frame: CGRect(x: 20, y: 20, width: 50, height: 50))
    private lazy var processedLabel = makeLabel(text: Constants.processedLabelText,
                                                size: 11,
                                                xCoordinate: 15,
                                                yCoordinate: 120)
    private lazy var sentLabel = makeLabel(text: Constants.sendLabelText,
                                           size: 14,
                                           xCoordinate: 90,
                                           yCoordinate: 20)
    private lazy var sentSmallLabel = makeLabel(text: Constants.sentLabelText,
                                                size: 11,
                                                xCoordinate: 160,
                                                yCoordinate: 120)
    private lazy var deliveredLabel = makeLabel(text: Constants.deliveredLabelText,
                                                size: 11,
                                                weight: .regular,
                                                xCoordinate: 280,
                                                yCoordinate: 120)
    private lazy var topChevronImageView = makeImageView(systemName: Constants.rightChevronSystemImageName,
                                                         tintColor: .systemGray,
                                                         frame: CGRect(x: 320, y: 40, width: 15, height: 15))
    private lazy var countLabel = makeLabel(text: Constants.countLabelText,
                                            size: 14,
                                            weight: .medium,
                                            xCoordinate: 90,
                                            yCoordinate: 45)
    private lazy var deliveryProgressView = makeProgressView()
    private lazy var recommendedLabel = makeLabel(text: Constants.recommendedLabelText,
                                                  size: 24,
                                                  frame: CGRect(x: 20, y: 670, width: 200, height: 60))
    private lazy var seeAllLabel = makeLabel(text: Constants.seeAllLabelText,
                                             textColor: .systemBlue,
                                             size: 16,
                                             weight: .regular,
                                             xCoordinate: 330,
                                             yCoordinate: 680)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addViews()
        addConstraints()
        loadFromUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentUserInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle
        switchUserInterfaceStyle(to: .light)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        switchUserInterfaceStyle(to: currentUserInterfaceStyle)
    }
    
    // MARK: - Objc Private Methods
    @objc private func imageChoiceAction() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        title = Constants.title
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addViews() {
        navigationController?.navigationBar.addSubview(avatarImageView)
        view.addSubview(productsScrollView)
        productsScrollView.addSubview(hereLabel)
        productsScrollView.addSubview(suggestedLabel)
        productsScrollView.addSubview(orderLabel)
        productsScrollView.addSubview(orderLightLabel)
        productsScrollView.addSubview(badgeImageView)
        productsScrollView.addSubview(rightChevronImageView)
        productsScrollView.addSubview(topLineView)
        productsScrollView.addSubview(bottomLineView)
        productsScrollView.addSubview(productView)
        productView.addSubview(middleLineView)
        productView.addSubview(airpodsImageView)
        productView.addSubview(processedLabel)
        productView.addSubview(sentLabel)
        productView.addSubview(sentSmallLabel)
        productView.addSubview(deliveredLabel)
        productView.addSubview(topChevronImageView)
        productView.addSubview(countLabel)
        productView.addSubview(deliveryProgressView)
        productsScrollView.addSubview(recommendedLabel)
        productsScrollView.addSubview(seeAllLabel)
    }
    
    private func addConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        if let navigationController {
            avatarImageView.trailingAnchor.constraint(equalTo: navigationController.navigationBar.trailingAnchor,
                                                      constant: -20).isActive = true
            avatarImageView.bottomAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor,
                                                    constant: -5).isActive = true
            avatarImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            avatarImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }
    
    private func switchUserInterfaceStyle(to style: UIUserInterfaceStyle) {
        overrideUserInterfaceStyle = style
        navigationController?.overrideUserInterfaceStyle = style
        tabBarController?.overrideUserInterfaceStyle = style
    }
    
    private func saveToUserDefaults(image: Data) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(image, forKey: Constants.avatarKey)
    }
    
    private func loadFromUserDefaults() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: Constants.avatarKey) as? Data else { return }
        guard let image = UIImage(data: data) else { return }
        avatarImageView.image = image
    }
}

// MARK: - Factory
private extension ForYouViewController {
    func makeLabel(text: String,
                   textColor: UIColor? = nil,
                   size: CGFloat,
                   weight: UIFont.Weight? = .bold,
                   xCoordinate: Int? = nil,
                   yCoordinate: Int? = nil,
                   frame: CGRect? = nil) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight ?? .bold)
        label.text = text
        if let textColor {
            label.textColor = textColor
        }
        label.frame = CGRect(x: xCoordinate ?? 0, y: yCoordinate ?? 0, width: 0, height: 0)
        if let frame {
            label.frame = frame
        }
        label.numberOfLines = 3
        label.sizeToFit()
        return label
    }
    
    func makeImageView(systemName: String? = nil,
                       named: String? = nil,
                       tintColor: UIColor? = nil,
                       frame: CGRect? = nil) -> UIImageView {
        let imageView = UIImageView()
        if let tintColor {
            imageView.tintColor = tintColor
        }
        if let systemName {
            imageView.image = UIImage(systemName: systemName)
        }
        if let named {
            imageView.image = UIImage(named: named)
        }
        if let frame {
            imageView.frame = frame
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.frame = view.frame
        scrollView.contentSize = CGSize(width: 393, height: 1000)
        scrollView.contentInset = UIEdgeInsets(top: -140, left: 0, bottom: 0, right: 0)
        return scrollView
    }
    
    private func makeProgressView() -> UIProgressView {
        let progressView = UIProgressView()
        progressView.setProgress(0.5, animated: true)
        progressView.frame = CGRect(x: 10, y: 100, width: 335, height: 5)
        progressView.tintColor = .systemGreen
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
        return progressView
    }
    
    private func makeAvatarImageView() -> UIImageView {
        let image = UIImageView()
        image.frame = CGRect(x: 340, y: 40, width: 40, height: 40)
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageChoiceAction))
        image.addGestureRecognizer(tapGestureRecognizer)
        image.isUserInteractionEnabled = true
        return image
    }

    private func makeProductView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.frame = CGRect(x: 20, y: 220, width: 353, height: 145)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.3
        return view
    }
    
    private func makeLineView(yCoordinate: CGFloat? = nil,
                              frame: CGRect? = nil) -> UIView {
        let line = UIView()
        line.backgroundColor = .systemGray6
        line.frame = CGRect(x: 15, y: yCoordinate ?? 0, width: view.frame.width - 30, height: 2)
        if let frame {
            line.frame = frame
        }
        return line
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ForYouViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let avatarImage = image.resizeImage(to: CGSize(width: 40, height: 40))
        self.avatarImageView.image = avatarImage
        guard let imageData = image.pngData() else { return }
        saveToUserDefaults(image: imageData)
        dismiss(animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ForYouViewController: UINavigationControllerDelegate {
}
