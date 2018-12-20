//
//  PurchaseTableViewController.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/18/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import UIKit
import os.log

class PurchaseTableViewController: UITableViewController {
    var purchases = [Purchase]()
    var fileName = "purchases"
    
    private func loadSamplePurchases() {
        let purchase1 = Purchase(total: UnitedStatesCurrency(dollars: 1, cents: 9) ?? UnitedStatesCurrency(), company: Company(name: "McDonald's"), category: Category(name: "food", color: "blue"), paymentType: PaymentType())
        
        let purchase2 = Purchase(total: UnitedStatesCurrency(dollars: 10, cents: 99) ?? UnitedStatesCurrency(), company: Company(name: "Game Stop"), category: Category(name: "games", color: "red"), paymentType: PaymentType())
        
        let purchase3 = Purchase(total: UnitedStatesCurrency(dollars: 40, cents: 00) ?? UnitedStatesCurrency(), company: Company(name: "Shell"), category: Category(name: "car", color: "green"), paymentType: PaymentType())
        
        purchases += [purchase1, purchase2, purchase3]
    }
    
    private func savePurchases() {
        //let fileManager = FileManager.default
        //let path = fileManager.currentDirectoryPath
        
        //let fileName = "purchases.json"
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json")  {
            print("saving")
            let jsonData = try! JSONEncoder().encode(purchases)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonData)
            print(url)
            //print(url.absoluteString)
            do {
                try jsonData.write(to: url, options: .atomic)
            } catch {
                print("could not save purchases")
            }
            
            do {
//                let jsonData = jsonString.data(using: .utf8)!
//                let decoder = JSONDecoder()
//                let purchase = try! decoder.decode([Purchase].self, from: jsonData)
//
//                //let data = try Data(contentsOf: URL(fileURLWithPath: url.absoluteString), options: .mappedIfSafe)
//                // let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                print(purchase)
                if let savedPurchases = loadPurchases(fileName: fileName) {
                    print("could load data")
                    //purchases += savedPurchases
                } else {
                    print("could not load data")
                }
            } catch {
                print("could not load data")
            }
        } else {
            print("failed to save")
        }
    }
//
//    let jsonData = try! JSONEncoder().encode(purchases)
//    let jsonString = String(data: jsonData, encoding: .utf8)!
//    print(jsonString)
//    //let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(purchases, toFile: Purchase.ArchiveURL.path)
//    do {
//    try NSKeyedArchiver.archivedData(withRootObject: purchases, requiringSecureCoding: false)
//    os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
//    } catch {
//    os_log("Failed to save meals...", log: OSLog.default, type: .error)
//    }
//}

    struct ResponseData: Decodable, Encodable {
        var purchases: [Purchase]
    }
    
    func loadPurchases(fileName: String) -> [Purchase]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Purchase].self, from: data)
                return jsonData
            } catch {
                print("cannot load purchases method")
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //use the edit button
        navigationItem.leftBarButtonItem = editButtonItem
        print("hi")
        if let savedPurchases = loadPurchases(fileName: fileName) {
            purchases += savedPurchases
        } else {
            loadSamplePurchases()
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            purchases.remove(at: indexPath.row)
            savePurchases()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    @IBAction func unwindToPurchasesList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController {
            let purchase = sourceViewController.purchase
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: purchases.count, section: 0)
            
            purchases.append(purchase ?? Purchase())
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
        savePurchases()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PurchaseTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PurchaseTableViewCell else  {
            fatalError("The dequeued cell is not an instance of PurchaseTableViewCell.")
        }
        
        let purchase = purchases[indexPath.row]
        
        cell.categoryLabel.text = purchase.category.display()
        cell.categoryLabel.backgroundColor = UIColor.init(named: purchase.category.displayColor())
        cell.dateLabel.text = "12/18"
        cell.purchaseNameLabel.text = purchase.company.display()
        cell.totalLabel.text = purchase.total.display()
        
        return cell
    }
}
