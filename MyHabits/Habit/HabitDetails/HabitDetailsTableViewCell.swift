//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by Артем on 19.05.2021.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Content
    // Label for date of tracked day
    private let trackedDayLabel: UILabel = {
        let trackedDayLabel = UILabel()
        
        trackedDayLabel.translatesAutoresizingMaskIntoConstraints = false
        return trackedDayLabel
    }()
    
    // Checkmark
    public let checkMarkImage: UIImageView = {
        let checkMarkImage = UIImageView()
        checkMarkImage.tintColor = .systemPurple
        checkMarkImage.image = UIImage(systemName: "checkmark")
        checkMarkImage.isHidden = true
        
        checkMarkImage.translatesAutoresizingMaskIntoConstraints = false
        return checkMarkImage
    }()
    
    
    // MARK: Initiali
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    // Setup views
    func setupViews() {
        
        contentView.addSubviews(
            trackedDayLabel,
            checkMarkImage
        )
        
        let contentViewHeight = contentView.heightAnchor.constraint(equalToConstant: 43.5)
        contentViewHeight.priority = .defaultHigh
        
        let constraints = [
            contentViewHeight,
            
            trackedDayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            trackedDayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            trackedDayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            
            checkMarkImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMarkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
   
}
