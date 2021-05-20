//
//  CheckboxButton.swift
//  MyHabits
//
//  Created by Артем on 18.05.2021.
//

import UIKit

// MARK: - Custom checkbox button
// Source: https://www.youtube.com/watch?v=R8SGEQXxhWw
final class CheckboxButton: UIView {

    public var isChecked = false
    
    private let checkMarkImageView: UIImageView = {
        let checkMarkImageView = UIImageView()
        checkMarkImageView.contentMode = .scaleAspectFit
        checkMarkImageView.tintColor = .white
        checkMarkImageView.image = UIImage(systemName: "checkmark")
        
        checkMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        return checkMarkImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemOrange.cgColor
        layer.cornerRadius = 19
        backgroundColor = .white
        
        addSubview(checkMarkImageView)
        
        let checkMarkConstraints = [
            checkMarkImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            checkMarkImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(checkMarkConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func toggle() {
//        self.isChecked.toggle()
//        
//        if self.isChecked {
//            backgroundColor = .systemOrange
//        } else {
//            backgroundColor = .white
//        }
//    }
}
