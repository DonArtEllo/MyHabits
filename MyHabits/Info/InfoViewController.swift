//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Артем on 09.05.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    // MARK: - Content
    // ScrollView
    private let scrollView = UIScrollView()
    private let containerView = UIView()
        
    // Title of info
    private let textTitle: UILabel = {
        let textTitle = UILabel()
        textTitle.text = "Привычка за 21 день"
        textTitle.font = .boldSystemFont(ofSize: 24)
        textTitle.numberOfLines = 1
    
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        return textTitle
    }()
    
    // Info header
    private let textHeader: UILabel = {
        let textHeader = UILabel()
        textHeader.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:"
        textHeader.numberOfLines = 0
    
        textHeader.translatesAutoresizingMaskIntoConstraints = false
        return textHeader
    }()
    
    // Info text (6 parts)
    private let textPartOne: UILabel = {
        let textPartOne = UILabel()
        textPartOne.text = "1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага."
        textPartOne.numberOfLines = 0
        
        textPartOne.translatesAutoresizingMaskIntoConstraints = false
        return textPartOne
    }()
    
    private let textPartTwo: UILabel = {
        let textPartTwo = UILabel()
        textPartTwo.text = "2. Выдержать 2 дня в прежнем состоянии самоконтроля."
        textPartTwo.numberOfLines = 0
    
        textPartTwo.translatesAutoresizingMaskIntoConstraints = false
        return textPartTwo
    }()
    
    private let textPartThree: UILabel = {
        let textPartThree = UILabel()
        textPartThree.text = "3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться."
        textPartThree.numberOfLines = 0
    
        textPartThree.translatesAutoresizingMaskIntoConstraints = false
        return textPartThree
    }()
    
    private let textPartFour: UILabel = {
        let textPartFour = UILabel()
        textPartFour.text = "4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств."
        textPartFour.numberOfLines = 0
    
        textPartFour.translatesAutoresizingMaskIntoConstraints = false
        return textPartFour
    }()
    
    private let textPartFive: UILabel = {
        let textPartFive = UILabel()
        textPartFive.text = "5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой."
        textPartFive.numberOfLines = 0
    
        textPartFive.translatesAutoresizingMaskIntoConstraints = false
        return textPartFive
    }()
    
    private let textPartSix: UILabel = {
        let textPartSix = UILabel()
        textPartSix.text = "6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся."
        textPartSix.numberOfLines = 0
    
        textPartSix.translatesAutoresizingMaskIntoConstraints = false
        return textPartSix
    }()
    
    // Info text footer
    private let footNote: UILabel = {
        let footNote = UILabel()
        footNote.text = "Источник: psychbook.ru"
        
        footNote.translatesAutoresizingMaskIntoConstraints = false
        return footNote
    }()
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: setupViews
    private func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubviews(
            textTitle,
            textHeader,
            textPartOne,
            textPartTwo,
            textPartThree,
            textPartFour,
            textPartFive,
            textPartSix,
            footNote
        )
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: navigationBarSpacer),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            textTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat(22)),
            textTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalSpacer),
            textTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1 * horizontalSpacer),
            
            textHeader.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: verticalSpacer + 4),
            textHeader.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalSpacer),
            textHeader.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1 * horizontalSpacer),
            
            textPartOne.topAnchor.constraint(equalTo: textHeader.bottomAnchor, constant: verticalSpacer),
            textPartOne.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalSpacer),
            textPartOne.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1 * horizontalSpacer),
            
            textPartTwo.topAnchor.constraint(equalTo: textPartOne.bottomAnchor, constant: verticalSpacer),
            textPartTwo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalSpacer),
            textPartTwo.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1 * horizontalSpacer),
            
            textPartThree.topAnchor.constraint(equalTo: textPartTwo.bottomAnchor, constant: verticalSpacer),
            textPartThree.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalSpacer),
            textPartThree.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1 * horizontalSpacer),
            
            textPartFour.topAnchor.constraint(equalTo: textPartThree.bottomAnchor, constant: verticalSpacer),
            textPartFour.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalSpacer),
            textPartFour.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1 * horizontalSpacer),
            
            textPartFive.topAnchor.constraint(equalTo: textPartFour.bottomAnchor, constant: verticalSpacer),
            textPartFive.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalSpacer),
            textPartFive.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1 * horizontalSpacer),
            
            textPartSix.topAnchor.constraint(equalTo: textPartFive.bottomAnchor, constant: verticalSpacer),
            textPartSix.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalSpacer),
            textPartSix.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1 * horizontalSpacer),
            
            footNote.topAnchor.constraint(equalTo: textPartSix.bottomAnchor, constant: verticalSpacer + 4),
            footNote.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalSpacer),
            footNote.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1 * horizontalSpacer),
            footNote.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -1 * (verticalSpacer + 4))
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
