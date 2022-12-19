//
//  NameResidentsTableViewCell.swift
//  Navigation
//
//  Created by Андрей Васильев on 07.12.2022.
//

import UIKit

class NameResidentsTableViewCell: UITableViewCell {

    let nameResidentLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 0
        return label
    }()

    private func layout() {
        contentView.addSubview(nameResidentLabel)
        NSLayoutConstraint.activate([
            nameResidentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameResidentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameResidentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameResidentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(model: Resident) {
        nameResidentLabel.text = model.name
    }

}
