//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Андрей Васильев on 14.05.2022.
//

import UIKit



class ProfileHeaderView: UIView {
    private let avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.5)
        view.toAutoLayout()
        return view
    }()
    private let avatarButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "clear.fill"), for: .normal)
        button.alpha = 0
        button.toAutoLayout()
        return button
    }()
    private let avatarEmptyView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        return view
    }()
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "avatar")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.toAutoLayout()
        return view
    }()
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Андрей Александрович Васильев"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    private let setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.toAutoLayout()
        return button
    }()
    private let statusTextField: UITextField = {
        
        let field = UITextField()
        field.backgroundColor = .white
        field.placeholder = "something..."
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 15)
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.indent(size: 10)
        field.toAutoLayout()
        return field
        
    }()

    private var leadingAvatarView = NSLayoutConstraint()
    private var topAvatarView = NSLayoutConstraint()
    private var widthAvatarView = NSLayoutConstraint()
    private var heightAvatarView = NSLayoutConstraint()

    func setupGesture() {
        //        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        //        swipeGesture.direction = .right
        //        avatarView.addGestureRecognizer(swipeGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        avatarView.addGestureRecognizer(tapGesture)
        let tapGetureAvatarButton = UITapGestureRecognizer(target: self, action: #selector(tapActionAvatarButton))
        avatarButton.addGestureRecognizer(tapGetureAvatarButton)
    }

    private func layout() {
        addSubviews(avatarEmptyView, fullNameLabel, statusLabel, setStatusButton, statusTextField, avatarView)
        avatarView.addSubviews(avatarImageView, avatarButton)
        leadingAvatarView = avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        topAvatarView = avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        widthAvatarView = avatarView.widthAnchor.constraint(equalToConstant: 100)
        heightAvatarView = avatarView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([
            avatarEmptyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarEmptyView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarEmptyView.widthAnchor.constraint(equalToConstant: 100),
            avatarEmptyView.heightAnchor.constraint(equalToConstant: 100),
            leadingAvatarView,
            topAvatarView,
            widthAvatarView,
            heightAvatarView,
            avatarImageView.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: avatarView.widthAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            avatarButton.topAnchor.constraint(equalTo: avatarView.topAnchor),
            avatarButton.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
            avatarButton.heightAnchor.constraint(equalToConstant: 30),
            avatarButton.widthAnchor.constraint(equalToConstant: 30),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarEmptyView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            statusLabel.leadingAnchor.constraint(equalTo: avatarEmptyView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 5),
            statusTextField.leadingAnchor.constraint(equalTo: avatarEmptyView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setStatusButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        layout()
        setupGesture()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func handleButtonTap() {
        
        statusTextChanged(statusTextField)
        statusLabel.text = statusText
        print("Show status")
        
    }
    
    @objc
    func statusTextChanged(_ textField: UITextField) {
        
        statusText = textField.text
        
    }

    @objc
    private func tapAction() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.leadingAvatarView.constant = 0
            self.topAvatarView.constant = 0
            self.heightAvatarView.constant = UIScreen.main.bounds.height
            self.widthAvatarView.constant = UIScreen.main.bounds.width
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarView.layoutIfNeeded()
        },
                       completion: {_ in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.avatarButton.alpha = 1
                self.avatarButton.layoutIfNeeded()
            },
                           completion: {_ in

            })
        })
    }

    @objc
    private func tapActionAvatarButton() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.avatarButton.alpha = 0
            self.avatarView.layoutIfNeeded()
        },
                       completion: {_ in
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.leadingAvatarView.constant = 16
                self.topAvatarView.constant = 16
                self.heightAvatarView.constant = 100
                self.widthAvatarView.constant = 100
                self.avatarImageView.layer.cornerRadius = 50
                self.avatarView.layoutIfNeeded()
            },
                           completion: {_ in

            })
        })
    }
}
