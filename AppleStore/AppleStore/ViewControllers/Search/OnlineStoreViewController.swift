//
//  OnlineStoreViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 10.10.22.
//

import UIKit
import WebKit

/// Online Store WKWebView
final class OnlineStoreViewController: UIViewController {
    // MARK: - Constants
    private enum Constant {
        static let homeURL = "https://www.apple.com/store"
    }
    // MARK: - Private Properties
    let url = URL(string: Constant.homeURL)
    private lazy var appleStoreWebView = makeWKWebView(url)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addViews()
    }
    
    private func addViews() {
        view.addSubview(appleStoreWebView)
    }
}

// MARK: - Factory
private extension OnlineStoreViewController {
    func makeWKWebView(_ homeURL: URL?) -> WKWebView {
        let webView = WKWebView()
        webView.frame = view.bounds
        guard let homeURL else { return webView }
        let request = URLRequest(url: homeURL)
        webView.load(request)
        return webView
    }
}
