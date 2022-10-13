//
//  SessionsViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 6.10.22.
//

import UIKit

/// Sessions. Today at Apple.
final class SessionsViewController: UIViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
}
