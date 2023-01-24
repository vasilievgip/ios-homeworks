//
//  LogInViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 15.06.2022.
//

import UIKit


class LogInViewController: UIViewController {

    weak var coordinator: MainProfileCoordinator?

    var loginDelegate: LoginViewControllerDelegate?

    private let nc = NotificationCenter.default

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.createColor(lightMode: viewColorLight, darkMode: viewColorDark)
        contentView.toAutoLayout()
        return contentView
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.toAutoLayout()
        return imageView
    }()

    private lazy var mailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = NSLocalizedString("mailTextFieldLogInViewController", comment: "")
        field.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        field.font = . systemFont(ofSize: 16)
        field.tintColor = UIColor(named: "Color_IOS20")
        field.autocapitalizationType = .none
        field.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.indent(size: 10)
        field.toAutoLayout()
        field.delegate = self
        return field
    }()

    private lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = NSLocalizedString("passwordTextFieldLogInViewController", comment: "")
        field.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        field.font = .systemFont(ofSize: 16)
        field.tintColor = UIColor(named: "Color_IOS20")
        field.autocapitalizationType = .none
        field.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.isSecureTextEntry = true
        field.indent(size: 10)
        field.toAutoLayout()
        field.delegate = self
        return field
    }()

    private var loginButton = CustomButton(title: NSLocalizedString("loginButtonLogInViewController", comment: ""),
                                           titleColor: .white,
                                           backgroundColor: UIColor(named: "Color_IOS20"),
                                           cornerRadius: 10)

    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(logoImageView, mailTextField, passwordTextField, loginButton)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            mailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            mailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.createColor(lightMode: viewColorLight, darkMode: viewColorDark)
        layout()
        loginButton.target = {
            self.handleButtonTap()
        }
        self.tabBarItem = UITabBarItem(title: NSLocalizedString("tabBarLogInViewController", comment: ""), image: UIImage(systemName: "person.fill"), tag: 2)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kddShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kddHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    func kddShow(nofitication: Notification){
        if let kddSize = (nofitication.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kddSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kddSize.height, right: 0)
        }
    }

    @objc
    func kddHide(){
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    @objc
    func handleButtonTap() {

        if mailTextField.text == "" || passwordTextField.text == "" {
            let alertNil = UIAlertController(title: NSLocalizedString("title1HandleButtonTapLogInViewController", comment: ""), message: NSLocalizedString("messageHandleButtonTapLogInViewController", comment: ""), preferredStyle: .alert)
            alertNil.addAction(UIAlertAction(title: NSLocalizedString("title2HandleButtonTapLogInViewController", comment: ""), style: .default, handler: { action in }))
            self.present(alertNil, animated: true)
        }
        
        loginDelegate?.checkCredentials(email: mailTextField.text!, password: passwordTextField.text!, completion: { alert, authResult  in
            if authResult == true {
                self.coordinator?.login()
            } else {
                self.present(alert, animated: true)
            }
        })

    }
    
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
