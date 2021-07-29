//
//  ToDoDetailsViewController.swift
//  ToDoListApp
//
//  Created by Santiago Gómez Giraldo - Ceiba Software on 28/07/21.
//

import UIKit

class ToDoDetailsViewController: UIViewController {

    @IBOutlet weak var toDoLabel: UILabel!
    
    var toDoElement: ToDoModelCD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let toDoElement = toDoElement else { return }
        switch toDoElement.priority {
        case 1:
            toDoLabel.text = "❗️" + (toDoElement.name ?? String())
        case 2:
            toDoLabel.text = "‼️" + (toDoElement.name ?? String())
        default:
            toDoLabel.text = toDoElement.name
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        let context = appDelegate.persistentContainer.viewContext
        if let toDoElementCD = toDoElement {
            context.delete(toDoElementCD)
        }
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
