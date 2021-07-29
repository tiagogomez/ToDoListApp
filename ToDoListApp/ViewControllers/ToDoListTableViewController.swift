//
//  ToDoListTableViewController.swift
//  ToDoListApp
//
//  Created by Santiago Gómez Giraldo - Ceiba Software on 27/07/21.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    var toDoElements: [ToDoModelCD] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDoElements()
    }
    
    private func getToDoElements() {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard let toDoElementsFromCD = try? context.fetch(ToDoModelCD.fetchRequest()),
              let toDoElements = toDoElementsFromCD as? [ToDoModelCD] else {
            return
        }
        self.toDoElements = toDoElements
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoElements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let selectedToDo = toDoElements[indexPath.row]
        switch selectedToDo.priority {
        case 1:
            cell.textLabel?.text = "❗️" + (selectedToDo.name ?? String())
        case 2:
            cell.textLabel?.text = "‼️" + (selectedToDo.name ?? String())
        default:
            cell.textLabel?.text = selectedToDo.name
        }
        if let data = selectedToDo.image {
            cell.imageView?.image = UIImage(data: data)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedToDo = toDoElements[indexPath.row]
        performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
            let context = appDelegate.persistentContainer.viewContext
            let selectedToDo = toDoElements[indexPath.row]
            context.delete(selectedToDo)
            appDelegate.saveContext()
            getToDoElements()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addToDoElementViewController = segue.destination as? AddToDoElementViewController {
            addToDoElementViewController.toDoListTableViewController = self
            return
        }
        if let toDoDetailsViewController = segue.destination as? ToDoDetailsViewController,
           let selectedToDo = sender as? ToDoModelCD {
            toDoDetailsViewController.toDoElement = selectedToDo
            return
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}
