//
//  SearchView.swift
//  Swifty
//
//  Created by Clothor- on 11/1/21.
//

import UIKit

// MARK: - SearchViewDelegate

protocol SearchViewDelegate: AnyObject {
    func searchButtonTapped(user: String)
}

// MARK: - SearchViewPresentationLogic

protocol SearchViewPresentationLogic {
    func disableInterface()
    func enableInterface()
}

// MARK: - SearchView

final class SearchView: UIView {
    weak var delegate: SearchViewDelegate?
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "42logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var textFieldView: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .center
        textField.delegate = self
        textField.textColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.00)
        textField.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 0.50)
        textField.layer.borderColor = CGColor(red: 0.00, green: 0.73, blue: 0.74, alpha: 1.00)
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let buttom = UIButton(type: .custom)
        buttom.translatesAutoresizingMaskIntoConstraints = false
        buttom.clipsToBounds = true
        buttom.setTitle("SEARCH", for: .normal)
        buttom.titleLabel?.font = UIFont(name: "PingFangHK-Semibold", size: 25)
        buttom.backgroundColor = UIColor(red: 0.00, green: 0.73, blue: 0.74, alpha: 1.00)
        buttom.addTarget(self, action: #selector(buttomTapped), for: .touchUpInside)
        buttom.layer.cornerRadius = 10
        
        return buttom
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.style = .large
        activity.color = UIColor(red: 0.79, green: 0.83, blue: 0.84, alpha: 1.00)
        return activity
    }()
    
    @objc func buttomTapped() {
        sendLogin()
    }
    
    required init(delegate: SearchViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        addSubviews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sendLogin() {
        textFieldView.resignFirstResponder()
        guard let userLogin = textFieldView.text else { return }
        disableInterface()
        let login = userLogin.filter{ !$0.isWhitespace }.lowercased()
        delegate?.searchButtonTapped(user: login)
    }
}

// MARK: - Extension

extension SearchView {
    func addSubviews() {
        addSubview(backgroundImageView)
        addSubview(logoImageView)
        addSubview(textFieldView)
        addSubview(searchButton)
        addSubview(activityIndicatorView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate(
            [
                backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                logoImageView.bottomAnchor.constraint(equalTo: textFieldView.topAnchor, constant: -40),
                logoImageView.centerXAnchor.constraint(equalTo: textFieldView.centerXAnchor),
                
                textFieldView.heightAnchor.constraint(equalToConstant: 30),
                textFieldView.widthAnchor.constraint(equalToConstant: 200),
                textFieldView.centerYAnchor.constraint(equalTo: centerYAnchor),
                textFieldView.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                searchButton.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 20),
                searchButton.heightAnchor.constraint(equalToConstant: 40),
                searchButton.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
                searchButton.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor),

                activityIndicatorView.centerXAnchor.constraint(equalTo: searchButton.centerXAnchor),
                activityIndicatorView.centerYAnchor.constraint(equalTo: searchButton.centerYAnchor),
            ]
        )
    }
}

// MARK: - UITextFieldDelegate

extension SearchView: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendLogin()
        return false
    }
}

// MARK: - SearchViewPresentationLogic

extension SearchView: SearchViewPresentationLogic {
    func disableInterface() {
        activityIndicatorView.startAnimating()
        searchButton.isUserInteractionEnabled = false
        searchButton.setTitle(nil, for: .normal)
        textFieldView.isUserInteractionEnabled = false
    }
    
    func enableInterface() {
        activityIndicatorView.stopAnimating()
        searchButton.isUserInteractionEnabled = true
        searchButton.setTitle("SEARCH", for: .normal)
        textFieldView.isUserInteractionEnabled = true
    }
}
