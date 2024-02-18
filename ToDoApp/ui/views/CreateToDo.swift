//
//  CreateToDo.swift
//  ToDoApp
//
//  Created by Samet Alkan on 17.02.2024.
//

import UIKit

class CreateToDo: UIViewController {

    @IBOutlet weak var tfNewTask: UITextField!
    
    var createToDoViewModel = CreateToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  

    @IBAction func buttonNewTask(_ sender: Any) {
        createToDoViewModel.create(todo_name: tfNewTask.text!)
    }
}
