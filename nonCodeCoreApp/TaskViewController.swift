//
//  TaskViewController.swift
//  nonCodeCoreApp
//
//  Created by Boris Alexandrov on 12.10.2022.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    var delegate: TaskViewControllerDelegate?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(
            red: 115/255,
            green: 150/255,
            blue: 222/255,
            alpha: 1
            )
        button.setTitle("Save Task", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(
            UIColor(
            red: 251/255,
            green: 242/255,
            blue: 207/255,
            alpha: 1
        ), for: .normal
        )
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(
            red: 250/255,
            green: 112/255,
            blue: 112/255,
            alpha: 1
            )
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(
            UIColor(
            red: 251/255,
            green: 242/255,
            blue: 207/255,
            alpha: 1
        ), for: .normal
        )
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: 148/255,
            green: 180/255,
            blue: 159/255,
            alpha: 1)
        setupSubviews(textField, saveButton, cancelButton)
        setConstraints()
        
   }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
    ])
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
}
    
    @objc private func save() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        task.title = textField.text
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
        delegate?.reloadData()
        dismiss(animated: true)
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
}
