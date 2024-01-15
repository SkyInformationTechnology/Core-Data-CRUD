//
//  HomeVC.swift
//  Core Data CRUD
//
//  Created by Md Akash on 15/1/24.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var itemTableView: UITableView!
    
    private let cellIdentifier: String = "itemCell"
    
    var items: [Item]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        itemTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        fetchItem()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBarButtonItemAction(_ sender: UIBarButtonItem) {
        let actionController = UIAlertController(title: "Add Item", message : nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            if actionController.textFields![0].text == "" {
                print("Title")
            } else {
                guard let name = actionController.textFields?[0].text else {
                    return
                }
                
                self.itemDataSave(name)
            }
        } )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        actionController.addAction(okAction)
        actionController.addAction(cancelAction)
        
        actionController.addTextField { textField -> Void in
            textField.placeholder = "Enter Title..."
        }
        
        self.present(actionController, animated: true, completion: nil)
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

// MARK: - Table View
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ItemTableViewCell {
            cell.configurateTheCell(items![indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}

// MARK: - Core Data

extension HomeVC {
    
    func itemDataSave(_ itemName: String) {
        let newItem = Item(context: self.context)
        newItem.name = itemName
        
        do {
            try self.context.save()
        } catch {
            print("Can't Save")
        }
        
        fetchItem()
    }
    
    func fetchItem() {
        do {
            let request = Item.fetchRequest() as NSFetchRequest<Item>
            self.items = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.itemTableView.reloadData()
            }
        }  catch {
            print("Can't Save")
        }
    }
    
    func deleteItem() {
        
    }
    
    func updateItem() {
        
    }
    
    
    // CRUD core data
}
