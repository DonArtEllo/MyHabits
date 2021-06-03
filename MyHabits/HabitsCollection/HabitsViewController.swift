//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Артем on 10.05.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private var habitDetailsViewController: HabitDetailsViewController?
    
    // MARK: - Content
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(named: "CustomWhite") ?? .white
        
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Funcions
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .init(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showCreateNewHabitViewControllerModaly))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Custom Purple") ?? .systemPurple
        
        view.backgroundColor = .white
        title = "Сегодня"
        
        view.addSubview(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Actions
    // Show view controller for creating new habit
    @objc func showCreateNewHabitViewControllerModaly() {
        
        let habitViewController = HabitViewController()
        present(habitViewController, animated: true)
        habitViewController.dataDelegator = self
    }
}

// MARK: - Extensions
// UICollectionViewDataSource
extension HabitsViewController: UICollectionViewDataSource {
    
    // Number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    // Number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    // Cell for item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            
            progressCell.progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
            progressCell.progressPercentageLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
                        
            return progressCell
            
        default:
            let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
        
            let habit = HabitsStore.shared.habits[indexPath.row]
            
            habitCell.delegateHabitCell = self
        
            habitCell.habit = habit
            habitCell.habit = HabitsStore.shared.habits[indexPath.item]
            
            if habitCell.habit?.isAlreadyTakenToday == true {
                habitCell.habitAchievedCheckboxButton.backgroundColor = habit.color
            } else {
                habitCell.habitAchievedCheckboxButton.backgroundColor = .white
            }
        
            return habitCell
        }
    }
}

// UICollectionViewDelegateFlowLayout
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    // Size for item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width - 30
        var heigth: CGFloat = 60
        
        switch indexPath.section {
        case 0:
            break
        case 1:
            heigth = 130
        default:
            break
        }
        
        return CGSize(width: width, height: heigth)
    }
    
    // Minimum line spacing for section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 12
    }
    
    // Minimum interitem spacing for section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return .zero
    }
    
    // Inset for section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 15, bottom: 0, right: 15)
        } else {
            return UIEdgeInsets(top: 18, left: 15, bottom: 15, right: 15)
        }
    }
    
    // Did select item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            let habit = HabitsStore.shared.habits[indexPath.item]
            habitDetailsViewController = HabitDetailsViewController(habit: habit)
            
            if habitDetailsViewController != nil {
                navigationController?.pushViewController(habitDetailsViewController!, animated: true)
                habitDetailsViewController!.callerFromDetailToHabits = self
            }
        }
    }
    
}

// UpdatingCollectionDataDelegate
extension HabitsViewController: UpdatingCollectionDataDelegate {
    
    // Updating data
    func updateCollection() {
        
        collectionView.reloadData()
    }
}
