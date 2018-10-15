//
//  AddTaskViewController.swift
//  ToDoApp
//
//  Created by 陰山賢太 on 2018/10/02.
//  Copyright © 2018年 Kageken. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    // MARK: - Properties

    //swiftlint:disable force_cast
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var task: Task?
    var taskCategory = "ToDo"

    // MARK: -

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if let task = task {
            taskTextField.text = task.name
            taskCategory = task.category!
            switch task.category! {
            case "ToDo":
                categorySegmentedControl.selectedSegmentIndex = 0
            case "Shopping":
                categorySegmentedControl.selectedSegmentIndex = 1
            case "Assignment":
                categorySegmentedControl.selectedSegmentIndex = 2
            default:
                categorySegmentedControl.selectedSegmentIndex = 0
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions of Buttons

    @IBAction func categoryChosen(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            taskCategory = "ToDo"
        case 1:
            taskCategory = "Shopping"
        case 2:
            taskCategory = "Assignment"
        default:
            taskCategory = "ToDo"
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func plusButtonTapped(_ sender: Any) {
        let taskName = taskTextField.text
        // 何も書かれていないときは戻る
        if taskName == "" {
            dismiss(animated: true, completion: nil)
            return
        }

        if task == nil {
            task = Task(context: context)
        }

        if let task = task {
            task.name = taskName
            task.category = taskCategory
        }

        // データベースへ保存
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        dismiss(animated: true, completion: nil)
    }

}
