//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Артем on 19.05.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
        
    var callerFromDetailToHabits: UpdatingCollectionDataDelegate?
    
    // MARK: - Content
    // Table view for habit's detail
    private lazy var habitDetailTableView: UITableView = {
        let habitDetailTableView = UITableView(frame: .zero, style: .grouped)
        
        habitDetailTableView.register(HabitDetailsHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: HabitDetailsHeaderView.self))
        habitDetailTableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailsTableViewCell.self))
        
        habitDetailTableView.delegate = self
        habitDetailTableView.dataSource = self
        
        habitDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        return habitDetailTableView
    }()
    
    private lazy var editHabitViewController = EditHabitViewController(habit: habit)
    
    let habit: Habit
    
    // MARK: Initializations
    init(habit: Habit) {
        
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editHabitViewController.delegatorForCalls = self
        
        view.backgroundColor = .systemGray6
        habitDetailTableView.backgroundColor = .systemGray6
        title = habit.name
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editThisHabit))
       
        view.addSubview(habitDetailTableView)
        
        let constraints = [
            habitDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitDetailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitDetailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // View wil appear
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // Little crutch for close current view when habit was deleted
    private func checkingForDeleting() {
        
        if editHabitViewController.checkerForDeletingHabitWithStyle {
            navigationController?.popViewController(animated: true)
            print("it worked")
        }
    }
    
    // MARK: - Actions
    // Open editing view for this habit
    @objc func editThisHabit() {
        navigationController?.present(editHabitViewController, animated: true, completion: nil)
    }
    
}

// MARK: - Extensions
// UITableViewDelegate
extension HabitDetailsViewController: UITableViewDelegate {
    
    // Height for header in section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
    }
}

// UITableViewDataSource
extension HabitDetailsViewController: UITableViewDataSource {
    
    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return HabitsStore.shared.dates.count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HabitDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self)) as! HabitDetailsTableViewCell
        
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: HabitsStore.shared.dates.count - 1 - indexPath.item)
        
        if HabitsStore.shared.habit(habit, isTrackedIn: HabitsStore.shared.dates[HabitsStore.shared.dates.count - 1 - indexPath.item]) == true {
            cell.checkMarkImage.isHidden = false
        }
        
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    // View for header in section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return HabitDetailsHeaderView()
    }
}

// MakeACallFromEditToDetail
extension HabitDetailsViewController: MakeACallFromEditToDetail {
    
    // Making a call
    func makeACall() {
        
        checkingForDeleting()
        self.callerFromDetailToHabits?.updateCollection()
    }
}
