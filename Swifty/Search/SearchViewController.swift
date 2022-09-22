//
//  SearchViewController.swift
//  Swifty
//
//  Created by Clothor- on 11/1/21.
//

import Foundation
import UIKit
import Alamofire

// MARK: - SearchDisplayLogic

protocol SearchDisplayLogic: AnyObject {
    func displayError()
    func displayError(message: String)
    func activateInterface()
}

// MARK: - SearchViewController

final class SearchViewController: UIViewController {

    // MARK: - Views

    private lazy var searchView = SearchView(delegate: self)
    let interactor: SearchBusinessLogic
    private var userName: String = ""

    // MARK: - Lifecycle
    
    required init(interactor: SearchBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override public func loadView() {
        view = searchView
    }
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func searchButtonTapped(user: String) {
        userName = user
        interactor.fetchUser(user)
    }
}

// MARK: - SearchDisplayLogic

extension SearchViewController: SearchDisplayLogic {
    func activateInterface() {
        searchView.enableInterface()
    }
    
    func displayError() {
        searchView.enableInterface()
        var title = ""
        var message = ""
        if userName.isEmpty {
            title = "No Username"
            message = "Username text field can't be empty!"
        } else {
            title = "Username Error"
            message = "The username: \(userName) was not found.\nPlease try again..."
        }
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertView, animated: true)
    }
    
    func displayError(message: String) {
        searchView.enableInterface()
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertView, animated: true)
    }
}
