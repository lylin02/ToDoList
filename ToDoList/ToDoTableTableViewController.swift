//
//  ToDoTableTableViewController.swift
//  ToDoList
//
//  Created by wlac on 7/13/20.
//  Copyright © 2020 Lily Lin. All rights reserved.
//

import UIKit

class ToDoTableTableViewController: UITableViewController {
    


      var toDos : [ToDoCD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToDos()
    }

       // toDos = createToDos()
    
    override func viewWillAppear(_ animated: Bool) {
      getToDos()
    }
    
    func getToDos() {
      if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        
        if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
            toDos = coreDataToDos
            
            tableView.reloadData()

      }
    }
        }
    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

         let toDo = toDos[indexPath.row]
        
        if let name = toDo.name {
            if toDo.important {
                cell.textLabel?.text = "❗️" + name
        } else {
          cell.textLabel?.text = toDo.name
        }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      // this gives us a single ToDo
      let toDo = toDos[indexPath.row]

      performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController {
          addVC.previousVC = self
        }
        if let completeVC = segue.destination as? CompleteToDoViewController {
        if let toDo = sender as? ToDoCD {
          completeVC.selectedToDo = toDo
          completeVC.previousVC = self
    }

  
         /*   func createToDos() -> [ToDo] {

              let swift = ToDo()
              swift.name = "Learn Swift"
              swift.important = true

              let dog = ToDo()
              dog.name = "Walk the Dog"
              // important is set to false by default

              return [swift, dog]
            }*/
}
}
}


