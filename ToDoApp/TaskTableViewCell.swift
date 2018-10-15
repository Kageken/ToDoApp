//
//  TaskTableViewCell.swift
//  ToDoApp
//
//  Created by 陰山賢太 on 2018/10/15.
//  Copyright © 2018 Kageken. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let reuseIdentifier = "TaskCell"

    // MARK: -

    @IBOutlet weak var taskLabel: UILabel!

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
