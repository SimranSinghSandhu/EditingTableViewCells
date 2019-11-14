//
//  ViewController.swift
//  EditingTableViewCells
//
//  Created by Simran Singh Sandhu on 14/11/19.
//  Copyright © 2019 Simran Singh Sandhu. All rights reserved.
//

import UIKit

class TableViewController : UITableViewController {

    let cellId = "cellId"
    var dataArr = ["Simran", "Singh", "Sandhu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        settingEditButton()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        cell.textLabel?.text = dataArr[indexPath.row]
        return cell
    }
    
    // Creating Edit Button
    func settingEditButton() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
        navigationItem.leftBarButtonItem = editButton
    }
    
    // When Edit Button is Pressed
    @objc func editButtonPressed() {
        UIView.animate(withDuration: 0.25) {
            self.isEditing = !self.isEditing
        }
        
        if isEditing {
            navigationItem.leftBarButtonItem?.title = "Done"
        } else {
            navigationItem.leftBarButtonItem?.title = "Edit"
        }
    }
}

// Editing Cells
extension TableViewController {
    
    // Enabling Deletion of Elements
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Deleting Elements
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            // Delete Element from Array and TableView with Animation
            dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        default:
            break
        }
    }
    
    // Enabling of Rearranging Elements
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Rearranging Elements
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = dataArr[sourceIndexPath.row]
        dataArr.remove(at: sourceIndexPath.row)
        dataArr.insert(item, at: destinationIndexPath.row)
    }
}

