//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Андрей Васильев on 14.05.2022.
//

import UIKit



class ProfileHeaderView: UIView {
    let avatarView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "avatar")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Андрей Васильев"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let waitingLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let textField: UITextField = {
        
        let field = UITextField()
        field.backgroundColor = .white
        field.placeholder = "something..."
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 16)
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.indent(size: 10)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
        
    }()
    private var statusText: String?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(waitingLabel)
        addSubview(postButton)
        postButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        addSubview(textField)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        avatarView.frame = CGRect(x: 16, y: 16, width: 100, height: 100)
        nameLabel.frame = CGRect(x: avatarView.frame.maxX + 16, y: 27, width: self.bounds.width - (avatarView.frame.maxX + 16) - 16, height: 36)
        waitingLabel.frame = CGRect(x: avatarView.frame.maxX + 16, y: nameLabel.frame.maxY, width: self.bounds.width - (avatarView.frame.maxX + 16) - 16, height: 35)
        textField.frame = CGRect(x: avatarView.frame.maxX + 16, y: waitingLabel.frame.maxY, width: self.bounds.width - (avatarView.frame.maxX + 16) - 16, height: 40)
        postButton.frame = CGRect(x: 16, y: textField.frame.maxY + 16, width: self.bounds.width - 32, height: 50)
        
    }
    
    @objc
    func handleButtonTap() {
        
        statusTextChanged(textField)
        waitingLabel.text = statusText
        print("Show status")
        
    }
    
    @objc
    func statusTextChanged(_ textField: UITextField) {
        
        statusText = textField.text
        
    }
}
