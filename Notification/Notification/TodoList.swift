//
//  ViewController.swift
//  Notification
//
//  Created by Karthikeyan Muthu on 23/10/23.
//

import UIKit

class TodoList: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var allReminder = [Reminder]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { done, err in
            if done
            {
                // will see
            }else if let error = err{
                print(error.localizedDescription)
            }
        }
        tableview.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")

        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
   @objc func cancelNotification(_ sender: UIButton) {
       let point = sender.convert(CGPoint.zero, to: tableview)
       if let indexPath = tableview.indexPathForRow(at: point) {
           // Remove the data from datasource
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [allReminder[indexPath.row].identifier])
           allReminder.remove(at: indexPath.row)
           print("Deleted reminder and notification")
           tableview.reloadData()
       }
       
   }

    @IBAction func addTask(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddTodo") as! AddTodo
        vc.completion = { title , date in
            DispatchQueue.main.async {
                print("Comes here")
                self.navigationController?.popToRootViewController(animated: true)
                let task = Reminder(name: title, date: date, identifier: "id_\(title)")
                self.allReminder.append(task)
                self.tableview.reloadData()
                
                let content = UNMutableNotificationContent()
                content.title = "Task Reminder"
                content.body = task.name
                
                let calendar = Calendar.current
                let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.year, .month, .day, .hour, .minute,.second], from: task.date), repeats: false)
                
                let request = UNNotificationRequest(identifier: task.identifier, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
                        print("Added notification")
                    }
                }
                
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TodoList: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allReminder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.task.text = allReminder[indexPath.row].name
        let date = allReminder[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM , dd YYYY"
        cell.time.text = formatter.string(from: date)
        cell.deleteBtn.addTarget(self, action: #selector(cancelNotification(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

