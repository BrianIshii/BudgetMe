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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //use the edit button
        navigationItem.leftBarButtonItem = editButtonItem
        purchases += Purchase.loadPurchasesOrDefault(fileName: fileName)
    }
    
    private func savePurchases(purchases: [Purchase]) {
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json")  {
            print("saving")
            let jsonData = try! JSONEncoder().encode(purchases)
            let jsonString = String(data: jsonData, encoding: .utf8)!
//            print(jsonData)
//            print(url)
            do {
                try jsonData.write(to: url, options: .atomic)
            } catch {
                print("could not save purchases")
            }
        } else {
            print("failed to save")
        }
    }

    struct ResponseData: Decodable, Encodable {
        var purchases: [Purchase]
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            purchases.remove(at: indexPath.row)
            savePurchases(purchases: purchases)
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
        
        savePurchases(purchases: purchases)
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
