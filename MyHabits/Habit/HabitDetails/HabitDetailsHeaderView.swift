//
//  HabitDetailsHeaderView.swift
//  MyHabits
//
//  Created by Артем on 19.05.2021.
//

import UIKit

class HabitDetailsHeaderView: UITableViewHeaderFooterView {

    // MARK: - Data from parent
    public var titleLabel: String? {
        didSet {
            habitActivityLabel.text = titleLabel
        }
    }
    
    // MARK: - Content
    // Label for habit's activity
    private let habitActivityLabel: UILabel = {
        let habitActivityLabel = UILabel()
        
        habitActivityLabel.text = "АКТИВНОСТЬ"
        habitActivityLabel.font = .systemFont(ofSize: 13)
        habitActivityLabel.textColor = .systemGray
        
        habitActivityLabel.translatesAutoresizingMaskIntoConstraints = false
        return habitActivityLabel
    }()
    
    // MARK: Initializations
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    // Setup views
    func setupViews() {
        
        contentView.backgroundColor = UIColor(named: "Custom White")
        contentView.addSubview(habitActivityLabel)
        
        let constraints = [
            habitActivityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacer),
            habitActivityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1 * smallVerticalSpacer)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
