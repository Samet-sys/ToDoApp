//
//  ToDoDaoRepository.swift
//  ToDoApp
//
//  Created by Samet Alkan on 17.02.2024.
//

import Foundation
import RxSwift


class ToDoDaoRepository {
    var toDoList = BehaviorSubject<[ToDos]>(value: [ToDos]())
    
    let db:FMDatabase?
    
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dataBaseURL = URL(fileURLWithPath: targetPath).appendingPathComponent("toDos.sqlite")
        db = FMDatabase(path: dataBaseURL.path)
    }
    
   
    
    func search(text:String){
        db?.open()
        var list = [ToDos]()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM toDos WHERE todo_name like '%\(text)%'", values: nil)
            while result.next(){
                let toDoListItems = ToDos(todo_id: Int(result.string(forColumn: "todo_id"))!, todo_name: result.string(forColumn: "todo_name")!)
                list.append(toDoListItems)
            }
            toDoList.onNext(list)
        }catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func create(todo_name:String){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO toDos (todo_name) VALUES (?)", values: [todo_name])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func edit(todo_id:Int, todo_name:String){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE toDos SET todo_name = ? WHERE todo_id = ?", values: [todo_name, todo_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func delete(todo_id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM toDos WHERE todo_id = ?", values: [todo_id])
           
            loadToDos()
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    //loads newest statue of database from device to app code
    func loadToDos(){
        db?.open()
        var list = [ToDos]()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM toDos", values: nil)
            while result.next(){
                let toDoListItems = ToDos(todo_id: Int(result.string(forColumn: "todo_id"))!, todo_name: result.string(forColumn: "todo_name")!)
                list.append(toDoListItems)
            }
            toDoList.onNext(list)
        }catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
        
        
}
