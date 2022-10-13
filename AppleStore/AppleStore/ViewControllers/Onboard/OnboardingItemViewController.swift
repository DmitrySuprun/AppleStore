//
//  OnboardingItemViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 13.10.22.
//

import UIKit

/// Current page for OnboardingPageViewController
class OnboardingItemViewController: UIViewController {
    // MARK: - Private Properties
    private let imageName: String
    private let headerLabelText: String
    private let greetingLabelText: String
    
    private lazy var backgroundImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: self.imageName)
        imageView.frame = CGRect(x: 0, y: 0, width: 393, height: 550)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var headerLabel = {
        let label = UILabel()
        label.text = self.headerLabelText
        label.frame = CGRect(x: 30, y: 490, width: 330, height: 50)
        label.font = UIFont.systemFont(ofSize: 35)
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    private lazy var greetingLabel = {
        let label = UILabel()
        label.text = self.greetingLabelText
        label.frame = CGRect(x: 30, y: 550, width: 330, height: 100)
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.alpha = 0

        return label
    }()
    
    // MARK: - Initializers
    init(imageName: String,
         headerLabelText: String,
         greetingLabelText: String) {
        self.imageName = imageName
        self.headerLabelText = headerLabelText
        self.greetingLabelText = greetingLabelText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 1, delay: 0) {
            self.greetingLabel.alpha = 1
            self.headerLabel.alpha = 1
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        greetingLabel.alpha = 0
        headerLabel.alpha = 0
    }
    
    // MARK: - Private Properties
    private func setupUI() {
        addViews()
        view.backgroundColor = .white
    }
    
    private func addViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(headerLabel)
        view.addSubview(greetingLabel)
    }
}
