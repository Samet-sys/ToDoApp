//
//  EditToDo.swift
//  ToDoApp
//
//  Created by Samet Alkan on 17.02.2024.
//

import UIKit

class EditToDo: UIViewController {

    @IBOutlet weak var tfEditTask: UITextField!
    
    var toDoCellInfo: ToDos?
    
    var ediToDoViewModel = EdiToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toDoInfo = toDoCellInfo {
            tfEditTask.text = toDoInfo.todo_name
        }
       
    }

    @IBAction func buttonEditTask(_ sender: Any) {
        if let todo_name = tfEditTask.text, let todoCell = toDoCellInfo {
            ediToDoViewModel.edit(todo_id: todoCell.todo_id, todo_name: todo_name)
        }
    }
    
}
