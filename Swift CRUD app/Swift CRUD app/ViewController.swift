//
//  ViewController.swift
//  Swift CRUD app
//
//  Created by Matheus Francisco da Silva Lima Gomes on 20/08/19.
//  Copyright © 2019 Gustavo Oliveira. All rights reserved.
//

import CoreData
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var listItemArray = [ListItem]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let item = listItemArray[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        context.delete(listItemArray[indexPath.row])
        listItemArray.remove(at: indexPath.row)
        saveData()
        
//        var textField = UITextField()
//        let alert = UIAlertController(title: "Change ListItem Name", message: "", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Update Item", style: .default) { (action) in
//            self.listItemArray[indexPath.row].setValue(textField.text, forKey: "name")
//            self.saveData()
//        }
//        alert.addAction(action)
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Novo item aqui"
//            textField = alertTextField
//        }
//        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create New ListItem", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = ListItem(context: self.context)
            
            newItem.name = textField.text
            self.listItemArray.append(newItem)
            self.saveData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Novo item aqui"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    func saveData(){
        do {
            try context.save()
        } catch {
            print("Erro salvando o contexto \(context)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        let request : NSFetchRequest<ListItem> = ListItem.fetchRequest()
        
        do {
            listItemArray = try context.fetch(request)
        } catch {
            print("Erro carregando dados \(error)")
        }
    }

}

