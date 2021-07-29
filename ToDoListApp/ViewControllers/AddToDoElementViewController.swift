//
//  AddToDoElementViewController.swift
//  ToDoListApp
//
//  Created by Santiago Gómez Giraldo - Ceiba Software on 27/07/21.
//

import UIKit

class AddToDoElementViewController: UIViewController {

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    
    var toDoListTableViewController: ToDoListTableViewController?
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
    }
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func mediaFolderTapped(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard let toDoName = taskNameTextField.text else {
            return
        }
        let toDoPriority = prioritySegment.selectedSegmentIndex
        let newToDoElement = ToDoModelCD(context: context)
        newToDoElement.name = toDoName
        newToDoElement.priority = Int32(toDoPriority)
        newToDoElement.image = imageView.image?.jpegData(compressionQuality: 1.0)
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

extension AddToDoElementViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
        pickerController.dismiss(animated: true, completion: nil)
    }
}
