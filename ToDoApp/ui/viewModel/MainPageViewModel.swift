//
//  MainPageViewModel.swift
//  ToDoApp
//
//  Created by Samet Alkan on 17.02.2024.
//

import Foundation
import RxSwift

class MainPageViewModel {
    var repo = ToDoDaoRepository()
    var toDoList = BehaviorSubject<[ToDos]>(value: [ToDos]())
    
    init() {
        copyDataBase()
        repo.toDoList = toDoList
        loadToDos()
    }
    func search(text:String){
        repo.search(text: text)
    }
    
    func delete(todo_id:Int){
        repo.delete(todo_id: todo_id)
    }
    
    func loadToDos(){
        repo.loadToDos()
    }
    
    //copy database to device from code path.
    func copyDataBase(){
        let bundlePath = Bundle.main.path(forResource: "toDos", ofType: ".sqlite")
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let copyPath = URL(fileURLWithPath: targetPath).appendingPathComponent("toDos.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: copyPath.path){
            print("Data base already exist!")
        }else{
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: copyPath.path)
            }catch{}
        }
    }
}
