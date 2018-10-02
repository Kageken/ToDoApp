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

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!

    // MARK: -

    var taskCategory = "ToDo"

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()


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
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}