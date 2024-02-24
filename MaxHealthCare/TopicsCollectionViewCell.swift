//
//  TopicsCollectionViewCell.swift
//  MaxHealthCare
//
//  Created by VJ on 21/02/24.
//

import UIKit
import SDWebImage
class TopicsCollectionViewCell: UICollectionViewCell {
    
    // Image view to display the image
    private lazy var topicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true // Ensures image does not overflow the cell bounds
        return imageView
    }()
    
    // Label to display text 
    private lazy var topicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    // Override initializer to setup the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Function to setup the UI elements
    private func setupUI() {
        // Add the image view to the cell's content view
        contentView.addSubview(topicImageView)
        topicImageView.translatesAutoresizingMaskIntoConstraints = false
        topicImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topicImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topicImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topicImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        
        // Add the label below the image view
        contentView.addSubview(topicLabel)
        topicLabel.translatesAutoresizingMaskIntoConstraints = false
        topicLabel.topAnchor.constraint(equalTo: topicImageView.bottomAnchor, constant: 0).isActive = true
        topicLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        topicLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
        topicLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8.0 // Optional: for rounded corners
    }
    
    // Function to set the image and label for the cell
    func configCell(_ image: String, text: String?) {
        topicImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgURL = URL(string: image )
        topicImageView.sd_setImage(with: imgURL,
                                       placeholderImage: UIImage(named: "placeHolder"),
                                       options: [.progressiveLoad, .continueInBackground ])
        topicLabel.text = text
    }
}
