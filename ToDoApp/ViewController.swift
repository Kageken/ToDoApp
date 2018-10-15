//
//  ViewController.swift
//  ToDoApp
//
//  Created by 陰山賢太 on 2018/10/01.
//  Copyright © 2018年 Kageken. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties

    private let segueEditTaskViewController = "SegueEditTaskViewController"

    //MARK: -

    @IBOutlet weak var taskTableView: UITableView!

    // MARK: - Properties for table view

    var tasks:[Task] = []
    var tasksToShow:[String:[String]] = ["ToDo":[], "Shopping":[], "Assignment":[]]
    let taskCategories:[String] = ["ToDo", "Shopping", "Assignment"]

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        taskTableView.dataSource = self
        taskTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
        taskTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Method of Getting data from Core Data

    func getData() {
        // swiftlint:disable force_cast
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            tasks = try context.fetch(fetchRequest)

            for key in tasksToShow.keys {
                tasksToShow[key] = []
            }
            for task in tasks {
                tasksToShow[task.category!]?.append(task.name!)
            }
        } catch {
            print("Fetching Failed.")
        }
    }

    // MARK: - Table View Data Source

    func numberOfSections(in tableView: UITableView) -> Int {
        return taskCategories.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return taskCategories[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksToShow[taskCategories[section]]!.count
    }

    // swiftlint:disable line_length
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = taskTableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as? TaskTableViewCell else {
            fatalError("Unexpected Index Path.")
        }

        let sectionData = tasksToShow[taskCategories[indexPath.section]]
        let cellData = sectionData?[indexPath.row]

        cell.taskLabel.text = "\(cellData!)"

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // swiftlint:disable force_cast
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        if editingStyle == .delete {
            let deletedCategory = taskCategories[indexPath.section]
            let deletedName = tasksToShow[deletedCategory]?[indexPath.row]
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name = %@ and category = %@", deletedName!, deletedCategory)

            do {
                let task = try context.fetch(fetchRequest)
                context.delete(task[0])
            } catch {
                print("Fetching Failed.")
            }

            (UIApplication.shared.delegate as! AppDelegate).saveContext()

            getData()
        }

        taskTableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? AddTaskViewController else {
            return
        }

        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        destinationViewController.context = context!
        if let indexPath = taskTableView.indexPathForSelectedRow, segue.identifier == segueEditTaskViewController {
            let editedCategory = taskCategories[indexPath.section]
            let editedName = tasksToShow[editedCategory]?[indexPath.row]
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()

            fetchRequest.predicate = NSPredicate(format: "name = %@ and category = %@", editedName!, editedCategory)

            do {
                let task = try context?.fetch(fetchRequest)
                destinationViewController.task = task![0]
            } catch {
                print("Fetching Failed.")
            }
        }
    }
}
