//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Артем on 16.05.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
      
    // MARK: - Content
    // Label for motivational phrase
    private let progressTitleLabel: UILabel = {
        let progressTitleLabel = UILabel()
        progressTitleLabel.text = "Всё получится!"
        progressTitleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        progressTitleLabel.textColor = .systemGray
        
        progressTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return progressTitleLabel
    }()
    
    // Label for progress percentage
    public let progressPercentageLabel: UILabel = {
        let progressPercentageLabel = UILabel()
        progressPercentageLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
        progressPercentageLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        progressPercentageLabel.textColor = .systemGray
        progressPercentageLabel.textAlignment = .right
        
        progressPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        return progressPercentageLabel
    }()
    
    // Progress Bar
    public let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    // MARK: Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcions
    // Setup views
    private func setupViews() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        contentView.addSubviews(
            progressTitleLabel,
            progressPercentageLabel,
            progressView
        )
        
        let constraints = [
            progressTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            progressPercentageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressPercentageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressView.topAnchor.constraint(equalTo: progressTitleLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressView.heightAnchor.constraint(equalToConstant: 7)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
