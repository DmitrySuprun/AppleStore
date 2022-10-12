//
//  ExtensionUIImage.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 12.10.22.
//

import UIKit

// MARK: -
extension UIImage {
    func resizeImage(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image {_ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
