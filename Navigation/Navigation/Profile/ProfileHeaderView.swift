//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Андрей Васильев on 14.05.2022.
//

import UIKit

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

class ProfileHeaderView: UIView {
    let avatarView = UIImageView(image: UIImage(named: "avatar"))
    let nameLabel = UILabel()
    let waitingLabel = UILabel()
    let button = UIButton()
    let textField = UITextField()
    private var statusText: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(avatarView)
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 50
        avatarView.layer.borderWidth = 3
        avatarView.layer.borderColor = UIColor.white.cgColor
        addSubview(nameLabel)
        nameLabel.text = "Андрей Васильев"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        addSubview(waitingLabel)
        waitingLabel.text = "Waiting for something..."
        waitingLabel.textColor = .gray
        waitingLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview((button))
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        addSubview(textField)
        textField.backgroundColor = .white
        textField.text = "something..."
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.indent(size: 10)
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
        button.frame = CGRect(x: 16, y: textField.frame.maxY + 16, width: self.bounds.width - 32, height: 50)
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
