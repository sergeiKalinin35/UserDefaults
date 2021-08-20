//
//  ViewController.swift
//  UserDefaults
//
//  Created by Sergey on 20.08.2021.
//

import UIKit

class ContactListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
   // private var contacts: [String] = []
    
    private var contacts: [Contact] = []
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // contacts = StorageManager.shared.fetchContacts()
        contacts = StorageManager.shared.fetchFromFile()
        
        
        
        // если что то есть в UserDefault извлекаем и отоброжаем во вью
     //   if let contactName = UserDefaults.standard.value(forKey: "ContactName") {
            //принудительное извлечение опционала знаем что тип данных string as!
     //       contacts.append(contactName as? String ?? "")
      //  }
        
        
        
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newContactVC = segue.destination as! NewContactViewController
        newContactVC.delegate = self
    }
    
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.fullName
    //    cell.textLabel?.text = contacts[indexPath.row]
        
        
        
        
        
        
        return cell
    }
}
// удаление ячейки справа на лево
extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            StorageManager.shared.deleteFromFile(at: indexPath.row)
           // StorageManager.shared.delete(at: indexPath.row)
            // дополнительно удаляем данные с UserDefaults
       //     UserDefaults.standard.removeObject(forKey: "ContactName")
            
            
            
            
        }
    }
    
}

extension ContactListViewController: NewContactViewControllerDelegate {
   // func saveContact(_ contact:String) {
    func saveContact(_ contact: Contact) {
        contacts.append(contact)
        tableView.reloadData()
    }
}



