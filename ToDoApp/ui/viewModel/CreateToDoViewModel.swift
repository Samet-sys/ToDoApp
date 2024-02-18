//
//  CreateToDoViewModel.swift
//  ToDoApp
//
//  Created by Samet Alkan on 17.02.2024.
//

import Foundation


class CreateToDoViewModel {
    var repo = ToDoDaoRepository()
    
    func create(todo_name:String){
        repo.create(todo_name: todo_name)
    }
}
