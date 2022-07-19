//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Андрей Васильев on 14.05.2022.
//

import UIKit



class ProfileHeaderView: UIView {
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
    private func layout() {
        addSubviews(avatarImageView, fullNameLabel, statusLabel, setStatusButton, statusTextField)
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 5),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setStatusButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        layout()
        
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
}
