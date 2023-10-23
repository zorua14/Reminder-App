//
//  AddTodo.swift
//  Notification
//
//  Created by Karthikeyan Muthu on 23/10/23.
//

import UIKit

class AddTodo: UIViewController {

    
    @IBOutlet weak var taskName: UITextField!
    
    @IBOutlet var datePickeer: UIDatePicker!
    
    public var completion: ((String,Date) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        if let task = taskName.text , !task.isEmpty{
            let sendDate = datePickeer.date
            completion?(task,sendDate)
        }else{
            AlertManager.shared.showAlert(from: self, withTitle: "Give a task", message: "Please fill the task field")
        }
    }
}
