//
//  ViewController.swift
//  nonCodeCoreApp
//
//  Created by Boris Alexandrov on 12.10.2022.
//

import UIKit
import CoreData

protocol TaskViewControllerDelegate {
    func reloadData()
}


class TaskListViewController: UITableViewController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let cellID = "task"
    private var taskList: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: 148/255,
            green: 180/255,
            blue: 159/255,
            alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        fetchDate()
        
    }
    
    private func setupNavigationBar() {
        title = "Task List"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor.init(
            red: 250/255,
            green: 112/255,
            blue: 112/255,
            alpha: 1
        )
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(
            red: 251/255,
            green: 242/255,
            blue: 207/255,
            alpha: 1
        )
        ]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(
            red: 251/255,
            green: 242/255,
            blue: 207/255,
            alpha: 1
        )
        ]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(
            red: 251/255,
            green: 242/255,
            blue: 207/255,
            alpha: 1
        )
    }
    
    @objc private func addNewTask() {
        let taskVC = TaskViewController()
        taskVC.delegate = self
        present(taskVC, animated: true)
    }
    
    private func fetchDate() {
        let fetchRequest = Task.fetchRequest()
        
        do {
            taskList = try context.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch data", error)
        }
    }
}

// MARK: - UITableViewDataSource
extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
    
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - TaskViewControllerDelegate
extension TaskListViewController: TaskViewControllerDelegate {
    func reloadData() {
        fetchDate()
        tableView.reloadData()
    }
    
}
