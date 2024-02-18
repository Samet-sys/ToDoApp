//
//  ViewController.swift
//  ToDoApp
//
//  Created by Samet Alkan on 17.02.2024.
//

import UIKit

class MainPage: UIViewController {
    //bind UI
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var toDoTableView: UITableView!
    
    var toDoList = [ToDos]()
    
    var mainPageViewModel = MainPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.barTintColor = UIColor(displayP3Red: 0.92, green: 0.884, blue: 0.952, alpha: 1)

        //bind protocols
        searchBar.delegate = self
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        _ = mainPageViewModel.toDoList.subscribe(onNext: { list in
            self.toDoList = list
            self.toDoTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainPageViewModel.loadToDos()
    }
    //send data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editToDo" {
            if let toDoInfo = sender as? ToDos {
                let editPage = segue.destination as! EditToDo
                editPage.toDoCellInfo = toDoInfo
            }
        }
    }

}

extension MainPage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainPageViewModel.search(text: searchText)
    }
}

extension MainPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let toDoList = toDoList[indexPath.row]
        
        let toDoCell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoCell
        toDoCell.labelCell.text = toDoList.todo_name
        
        return toDoCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDoList = toDoList[indexPath.row]
        performSegue(withIdentifier: "editToDo", sender: toDoList)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deletionAction = UIContextualAction(style: .destructive, title: "Delete"){ contextualAction,view,bool in
            
            let toDoList = self.toDoList[indexPath.row]
            
            
            let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ action in
                self.mainPageViewModel.delete(todo_id: toDoList.todo_id)
            }
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deletionAction])
    }
    
}
