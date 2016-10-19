//
//  ViewController.swift
//  ToDoList
//
//  Created by Sgmedical on 2016/10/19.
//  Copyright © 2016年 Sgmedical. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    //display tasks while loading them from core data
    override func viewWillAppear(_ animated: Bool) {
        // bring the data and load them from core data
        getData()
        
        //reload the table view
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        
        if task.isImportant{
            cell.textLabel?.text = "😀 \(task.name!)"
        } else {
            cell.textLabel?.text = task.name!
        }
        
        return cell
    }
    
    // get data from core data entity
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            tasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    // allow delete the records
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete{
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //reload the data again
            do{
                tasks = try context.fetch(Task.fetchRequest())
            } catch {
                print("Fetching error")
            }
            
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

