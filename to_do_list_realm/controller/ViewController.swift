//
//  ViewController.swift
//  to_do_list_realm
//
//  Created by Petar Perich on 27.04.2021.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var items: Results<TaskList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationController?.navigationBar.barTintColor = UIColor.purple
        items = realm.objects(TaskList.self)
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New task", message: "Print a new task", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else {return}
            
            let task = TaskList()
            task.task = textField.text!
            
            try! self?.realm.write{
                self?.realm.add(task)
            }
            
            self?.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

//MARK:- Data Source & Delegate
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if items.count != 0{
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskTableViewCell
        let item = items[indexPath.row]
        cell.taskLabel.text = item.task
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let editingRow = items [indexPath.row]
        if editingStyle == .delete{
            tableView.beginUpdates()
            try! self.realm.write{
                self.realm.delete(editingRow)
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    
}
