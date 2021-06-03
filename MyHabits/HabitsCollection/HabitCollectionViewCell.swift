//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Артем on 13.05.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var delegateHabitCell: UpdatingCollectionDataDelegate?
    
    // MARK: Data from Storage
    var habit: Habit? {
        didSet {
            habitNameLabel.text = habit?.name
            habitNameLabel.textColor = habit?.color
            habitTimeLabel.text = habit?.dateString
            habitAchievedCheckboxButton.layer.borderColor = habit?.color.cgColor
            habitAchievedCounterLabel.text = "Счётчик: \((habit?.trackDates.count)!)"
        }
    }
    
    // MARK: - Content
    // Label for habit's name
    private let habitNameLabel: UILabel = {
        let habitNameLabel = UILabel()
        habitNameLabel.numberOfLines = 2
        
        return habitNameLabel
    }()
    
    // Label for habit's time
    private let habitTimeLabel: UILabel = {
        let habitTimeLabel = UILabel()
        habitTimeLabel.font = .systemFont(ofSize: 12)
        habitTimeLabel.textColor = .systemGray2
        
        return habitTimeLabel
    }()
    
    // Label for counter of habit's achieved days
    private let habitAchievedCounterLabel: UILabel = {
        let habitAchievedCounterLabel = UILabel()
        habitAchievedCounterLabel.font = .systemFont(ofSize: 13)
        habitAchievedCounterLabel.textColor = .systemGray
        
        return habitAchievedCounterLabel
    }()
    
    // Checkbox Button
    public let habitAchievedCheckboxButton: CheckboxButton = {
        let habitAchievedCheckboxButton = CheckboxButton(frame:
                                                            CGRect(
                                                                x: 0,
                                                                y: 0,
                                                                width: 1,
                                                                height: 1
                                                            )
        )
        habitAchievedCheckboxButton.widthAnchor.constraint(equalToConstant: 38).isActive = true
        habitAchievedCheckboxButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        habitAchievedCheckboxButton.isUserInteractionEnabled = true
        
        return habitAchievedCheckboxButton
    }()
    
    // MARK: Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupGestures()
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
            habitNameLabel,
            habitTimeLabel,
            habitAchievedCounterLabel,
            habitAchievedCheckboxButton
        )
        
        let constraints = [
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -103),
            
            habitTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            habitTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            habitAchievedCounterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitAchievedCounterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            habitAchievedCheckboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            habitAchievedCheckboxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Actions
    // Setup gestures
    private func setupGestures() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnCheckboxButton))
        habitAchievedCheckboxButton.addGestureRecognizer(gesture)
    }
    
    // Tap on Checkbox Button
    @objc func didTapOnCheckboxButton() {
        
        toggle()
    }
    
    // Toggling Checkbox button
    func toggle() {
        
        if habitAchievedCheckboxButton.isChecked {
            return
        }
        
        habitAchievedCheckboxButton.isChecked.toggle()
        
        if habitAchievedCheckboxButton.isChecked {
            habitAchievedCheckboxButton.backgroundColor = habit?.color
            if habit?.isAlreadyTakenToday == true {
                print("A habit is already tracked tooday")
            } else {
                HabitsStore.shared.track(habit!)
                print("User succesfuly tracked a habit")
                contentView.reloadInputViews()
                
                self.delegateHabitCell?.updateCollection()
            }
        } else {
            habitAchievedCheckboxButton.backgroundColor = .white
        }
        
    }
    
}
