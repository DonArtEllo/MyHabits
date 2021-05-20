//
//  EditHabitViewController.swift
//  MyHabits
//
//  Created by Артем on 19.05.2021.
//

import UIKit
/* MARK: - Q: How to add following code
 Source: https://stackoverflow.com/questions/56567539/multi-component-picker-uipickerview-in-swiftui?newreg=1f1f61a09fdb4e2ab886fb29ed774ba1
import SwiftUI

struct TimerView: View {
    @State private var hours = Calendar.current.component(.hour, from: Date())
    @State private var minutes = Calendar.current.component(.minute, from: Date())

    var body: some View {
        TimeEditPicker(selectedHour: $hours, selectedMinute: $minutes)
    }
}

struct TimeEditPicker: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                Picker("", selection: self.$selectedHour) {
                    ForEach(0..<24) {
                        Text(String($0)).tag($0)
                    }
                }
                .labelsHidden()
                .fixedSize(horizontal: true, vertical: true)
                .frame(width: geometry.size.width / 5, height: 160)
                .clipped()

                Picker("", selection: self.$selectedMinute) {
                    ForEach(0..<60) {
                        Text(String($0)).tag($0)
                    }
                }
                .labelsHidden()
                .fixedSize(horizontal: true, vertical: true)
                .frame(width: geometry.size.width / 5, height: 160)
                .clipped()

                Spacer()
            }
        }
        .frame(height: 160)
        .mask(Rectangle())
    }
}
*/

class EditHabitViewController: UIViewController {
    
    public var checkerForDeletingHabitWithStyle = false
    
    var delegatorForCalls: MakeACallFromEditToDetail?
    weak var dataDelegator: UpdatingCollectionDataDelegate?

    public var habit: Habit
    private var habitColor: UIColor = .systemOrange
    
    // MARK: - Content
    // Name Label
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "НАЗВАНИЕ"
        nameLabel.font = .boldSystemFont(ofSize: 13)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    // Name of new habit Text Field
    private let newHabitNameTextField: UITextField = {
        let newHabitNameTextField = UITextField()
        newHabitNameTextField.font = .systemFont(ofSize: 17)
        newHabitNameTextField.textColor = UIColor(named: "Custom Blue") ?? .systemBlue
        newHabitNameTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        newHabitNameTextField.returnKeyType = .done
        
        newHabitNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return newHabitNameTextField
    }()
    
    // Color Label
    private let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = .boldSystemFont(ofSize: 13)
        
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        return colorLabel
    }()
    
    // Color Picker for new habit
    private let newHabitColorPickerButton: UIButton = {
        let newHabitColorPickerButton = UIButton(frame:
                                                    CGRect(
                                                        x: 0,
                                                        y: 0,
                                                        width: 1,
                                                        height: 1
                                                    )
        )
        newHabitColorPickerButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        newHabitColorPickerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        newHabitColorPickerButton.backgroundColor = UIColor(named: "CustomOrange") ?? .systemOrange
        
        newHabitColorPickerButton.layer.cornerRadius = 15
        
        newHabitColorPickerButton.isUserInteractionEnabled = true
        newHabitColorPickerButton.addTarget(self, action: #selector(didTappedOnColorPicker), for: .touchUpInside)
        
        newHabitColorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        return newHabitColorPickerButton
    }()
    
    // Time Label
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = .boldSystemFont(ofSize: 13)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    // New habit time text
    private let newHabitTimeLabel: UILabel = {
        let newHabitTimeLabel = UILabel()
        newHabitTimeLabel.text = "Каждый день в "
        
        newHabitTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return newHabitTimeLabel
    }()
    
    // New habit Time Picker
    // MARK: - Q: How to make DatePicker look like in Figma.com (Design)
    private let newHabitTimeDatePicker: UIDatePicker = {
        let newHabitTimeDatePicker = UIDatePicker()
        newHabitTimeDatePicker.datePickerMode = .time
        
        newHabitTimeDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return newHabitTimeDatePicker
    }()
    
    // Delete habit button
    let deleteHabitButton: UIButton = {
        let deleteHabitButton = UIButton(type: .system)
        deleteHabitButton.setTitle("Удалить привычку", for: .normal)
        deleteHabitButton.setTitleColor(.red, for: .normal)
        deleteHabitButton.addTarget(self, action: #selector(showDeleteAlert(_:)), for: .touchUpInside)
        
        deleteHabitButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteHabitButton
    }()
    
    // MARK: Initializations
    init(habit: Habit) {
        
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  - Functions
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkerForDeletingHabitWithStyle = false
        
        view.backgroundColor = .white
        habitColor = newHabitColorPickerButton.backgroundColor!
        
        newHabitNameTextField.delegate = self
        
        newHabitNameTextField.text = habit.name
        newHabitColorPickerButton.backgroundColor = habit.color

        setupViews()
        setupNavBar()
    }
    
    // Setup views
    private func setupViews() {
        view.addSubviews(
            nameLabel,
            newHabitNameTextField,
            colorLabel,
            newHabitColorPickerButton,
            timeLabel,
            newHabitTimeLabel,
            newHabitTimeDatePicker,
            deleteHabitButton
        )

        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: navigationBarSpacer + contentVerticalSpacer),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacer),
            
            newHabitNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: smallVerticalSpacer),
            newHabitNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacer),
            newHabitNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -1 * horizontalSpacer),
            
            colorLabel.topAnchor.constraint(equalTo: newHabitNameTextField.bottomAnchor, constant: bigVerticalSpacer),
            colorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacer),
            
            newHabitColorPickerButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: smallVerticalSpacer),
            newHabitColorPickerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacer),
            
            timeLabel.topAnchor.constraint(equalTo: newHabitColorPickerButton.bottomAnchor, constant: bigVerticalSpacer),
            timeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacer),
            
            newHabitTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: smallVerticalSpacer),
            newHabitTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacer),
            
            newHabitTimeDatePicker.leadingAnchor.constraint(equalTo: newHabitTimeLabel.trailingAnchor),
            newHabitTimeDatePicker.centerYAnchor.constraint(equalTo: newHabitTimeLabel.centerYAnchor),
            
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            deleteHabitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // Setup navigation bar
    private func setupNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        
        let navItem = UINavigationItem(title: "Создать")
        
        let saveItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveTabBarButtonPressed))
        
        navItem.rightBarButtonItem = saveItem
        
        let cancelItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelTabBarButtonPressed))
        
        navItem.leftBarButtonItem = cancelItem
        navBar.setItems([navItem], animated: false)
        
        saveItem.tintColor = .purple
        cancelItem.tintColor = .purple
    }
    
    // MARK: - Actions
    // Saving edited info for habit
    @objc func saveTabBarButtonPressed(_ sender: UIBarButtonItem) {
        
        if ((newHabitNameTextField.text?.isEmpty) != Optional(false)) {
            newHabitNameTextField.text = "Тут должно быть что-то грандиозное (но вы не указали что...)"
        }
        
        let editedHabit = Habit(
            name: newHabitNameTextField.text ?? "NO DATA",
            date: newHabitTimeDatePicker.date,
            color: habitColor
        )
        reloadInputViews()
        if let index = HabitsStore.shared.habits.firstIndex(where: { $0 == self.habit }) {
            HabitsStore.shared.habits[index] = editedHabit
        }
        
        dismiss(animated: true) { [weak self] in
            self?.delegatorForCalls?.makeACall()
        }
    }
    
    // Cancel editing habit
    @objc func cancelTabBarButtonPressed(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // Opening color picker
    @objc private func didTappedOnColorPicker() {
        
        let colorPickerViewController = UIColorPickerViewController()
        colorPickerViewController.delegate = self
        colorPickerViewController.supportsAlpha = false
        present(colorPickerViewController, animated: true)
    }
    
    // Show allert before deleting habit
    @objc func showDeleteAlert(_ sender: Any) {

        let deleteAlertController = UIAlertController(title: "Удалить привычку?", message: "Вы хотите удалить привычку \(habit.name)?", preferredStyle: .alert)

        let cancelDeleteAction = UIAlertAction(title: "Отмена", style: .default) { _ in
        }

        let completeDeleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            if let oldHabit = HabitsStore.shared.habits.firstIndex(where: ({ $0.name == self.habit.name })) {
                HabitsStore.shared.habits.remove(at: oldHabit )
            }
            
            self.checkerForDeletingHabitWithStyle.toggle()
            
            self.dismiss(animated: true) { [weak self] in
                self?.delegatorForCalls?.makeACall()
            }
        }
        
        deleteAlertController.addAction(cancelDeleteAction)
        deleteAlertController.addAction(completeDeleteAction)
        
        self.present(deleteAlertController, animated: true, completion: nil)
    }
}

// MARK: - Extensions
// UIColorPickerViewControllerDelegate
extension EditHabitViewController: UIColorPickerViewControllerDelegate {
    
    // Color picker view controller did finish
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        habitColor = selectedColor
        newHabitColorPickerButton.backgroundColor = selectedColor
    }
    
    // Color picker view controller did select color
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        habitColor = selectedColor
        newHabitColorPickerButton.backgroundColor = selectedColor
    }
}

// UITextFieldDelegate
extension EditHabitViewController: UITextFieldDelegate {
    
    // Text field should return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        newHabitNameTextField.resignFirstResponder()
        return true
    }
}
