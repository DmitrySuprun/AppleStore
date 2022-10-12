//
//  OnlineStoreViewController.swift
//  AppleStore
//
//  Created by Дмитрий Супрун on 10.10.22.
//

import UIKit
import WebKit

/// Online Store WKWebView browser
final class OnlineStoreViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let emptyString = ""
        static let localPDF = "iOSNotesForProfessionals"
        static let extensionPDF = "pdf"
        static let systemNameChevronBack = "chevron.backward"
        static let systemNameChevronForward = "chevron.forward"
        static let systemNameShare = "square.and.arrow.up"
        static let systemNameInfo = "info.circle"
    }
    
    // MARK: - Public Properties
    var currentProduct: Product?
    var observation: NSKeyValueObservation?
    
    // MARK: - Private Properties
    private lazy var url = URL(string: currentProduct?.url ?? Constants.emptyString)
    private lazy var browserWebView = makeWKWebView(url)
    private lazy var navigationToolBar = makeToolBar()
    private lazy var loadProgress = makeProgressView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObservation()
    }

    // MARK: - Objc Private Methods
    @objc private func previousPageAction() {
        guard browserWebView.canGoBack else { return }
        browserWebView.goBack()
    }
    
    @objc private func nextPageAction() {
        guard browserWebView.canGoForward else { return }
        browserWebView.goForward()
    }
    
    @objc private func reloadPage() {
        browserWebView.reload()
    }
    
    @objc private func openPDF() {
        if let pdfURL = Bundle.main.url(forResource: Constants.localPDF, withExtension: Constants.extensionPDF) {
            browserWebView.loadFileURL(pdfURL, allowingReadAccessTo: pdfURL)
        }
    }
    
    @objc private func shareURL() {
        guard let shareURL = browserWebView.url else { return }
        let activityController = UIActivityViewController(activityItems: [shareURL],
                                                          applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addViews()
    }

    private func addViews() {
        view.addSubview(browserWebView)
        view.addSubview(navigationToolBar)
        navigationToolBar.sizeToFit()
        view.addSubview(loadProgress)
    }
    
    private func addObservation() {
        observation = browserWebView.observe(\.estimatedProgress, options: .new, changeHandler: { _, _ in
            self.loadProgress.progress = Float(self.browserWebView.estimatedProgress)
            if self.browserWebView.estimatedProgress == 1 {
                self.loadProgress.isHidden = true
            } else {
                self.loadProgress.isHidden = false
            }
        })
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
        webView.scrollView.delegate = self
        return webView
    }
    
    func makeToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.systemNameChevronBack),
                                                style: .plain,
                                                target: self,
                                                action: #selector(previousPageAction))
        let forwardBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.systemNameChevronForward),
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(nextPageAction))
        let shareBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.systemNameShare),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(shareURL))
        let infoBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.systemNameInfo),
                                                style: .plain,
                                                target: self,
                                                action: #selector(openPDF))
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                   target: self,
                                                   action: #selector(reloadPage))
        let flexibleSpaceItem = UIBarButtonItem(systemItem: .flexibleSpace)
        toolBar.frame = CGRect(x: 0, y: 720, width: 0, height: 0)
        toolBar.setItems([
            backBarButtonItem,
            flexibleSpaceItem,
            forwardBarButtonItem,
            flexibleSpaceItem,
            shareBarButtonItem,
            flexibleSpaceItem,
            infoBarButtonItem,
            flexibleSpaceItem,
            refreshBarButtonItem
        ], animated: true)
        return toolBar
    }
    
    func makeProgressView() -> UIProgressView {
        let progressView = UIProgressView()
        progressView.frame = CGRect(x: 0, y: 716, width: 393, height: 5)
        return progressView
    }
}

// MARK: - UIScrollViewDelegate
extension OnlineStoreViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        navigationToolBar.isHidden = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        navigationToolBar.isHidden = false
    }
}
