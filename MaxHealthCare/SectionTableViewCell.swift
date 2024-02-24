//
//  SectionTableViewCell.swift
//  MaxHealthCare
//
//  Created by VJ on 22/02/24.
//

import UIKit

class SectionTableViewCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0 // Allow multiple lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(labelContainerView)
        labelContainerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            labelContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            labelContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            labelContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            label.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor ,constant: 5),
            label.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor ,constant: 5),
            label.topAnchor.constraint(equalTo: labelContainerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
