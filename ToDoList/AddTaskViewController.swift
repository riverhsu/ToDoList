//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Sgmedical on 2016/10/19.
//  Copyright © 2016年 Sgmedical. All rights reserved.
//

import Foundation
import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isImp: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnTapped(_ sender: AnyObject) {
        
        // access persistentContainer.viewContext
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        task.name = textField.text!
        task.isImportant = isImp.isOn
        
        //save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // push the new task back to the navigation controller
        navigationController!.popViewController(animated: true)
        
    }
    
}
