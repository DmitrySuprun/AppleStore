//
//  ImageInfoViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 6.10.22.
//

import UIKit

/// Information about current product
final class ImageInfoViewController: UIViewController {
    // MARK: - Public Properties
    var productImage: String?
    var productName: String?
    
    // MARK: - Private Properties
    private lazy var productLabel = {
        let label = UILabel()
        label.text = productImage
        label.frame = CGRect(x: 140, y: 150, width: 170, height: 25)
        return label
    }()
    
    private lazy var productImageView = {
        let image = UIImageView()
        image.image = UIImage(named: productImage ?? "")
        image.frame = CGRect(x: 50, y: 200, width: 300, height: 300)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(productImageView)
        view.addSubview(productLabel)
    }
}
