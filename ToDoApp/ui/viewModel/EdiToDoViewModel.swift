//
//  EdiToDoViewModel.swift
//  ToDoApp
//
//  Created by Samet Alkan on 17.02.2024.
//

import Foundation


class EdiToDoViewModel {
    var repo = ToDoDaoRepository()
    
    func edit(todo_id:Int, todo_name:String){
        repo.edit(todo_id: todo_id, todo_name: todo_name)
    }
}
