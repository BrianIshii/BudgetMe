//
//  PurchaseTableViewController.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/18/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import UIKit
import os.log

class TransactionTableViewController: UITableViewController {
    var purchases = [Purchase]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //use the edit button
        navigationItem.leftBarButtonItem = editButtonItem
        purchases += PurchaseDatabaseAccess.loadPurchasesOrDefault()
    }
    
    struct ResponseData: Decodable, Encodable {
        var purchases: [Purchase]
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            purchases.remove(at: indexPath.row)
            PurchaseDatabaseAccess.trySavePurchases(purchases: purchases)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // coming back to view
    @IBAction func unwindToPurchasesList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController {
            let purchase = sourceViewController.purchase
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: purchases.count, section: 0)
            
            purchases.append(purchase ?? Purchase())
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        } else if let sourceViewController = sender.source as? TransactionViewController {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let transaction = sourceViewController.transaction
                print("other unwind")
                print(transaction.category.display())
                purchases[selectedIndexPath.row] = transaction
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
        }
        
        PurchaseDatabaseAccess.trySavePurchases(purchases: purchases)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PurchaseTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TransactionTableViewCell else  {
            fatalError("The dequeued cell is not an instance of PurchaseTableViewCell.")
        }
        
        let purchase = purchases[indexPath.row]
        
        let endIndex = purchase.time.firstIndex(of: " ") ?? purchase.time.endIndex
        let startIndex = purchase.time.firstIndex(of: "-") ?? purchase.time.endIndex
        let range = purchase.time.index(after: startIndex)..<endIndex
        
        
        //print(purchase.time[range])
        //print(purchase.time.firstIndex(of: "-") ?? purchase.time.endIndex)
        //let beginning = purchase.time[startIndex..<index]
        //let newString = String(beginning)
        //print(newString)
        
        cell.categoryLabel.text = purchase.category.display()
        cell.categoryLabel.backgroundColor = UIColor.init(named: purchase.category.displayColor())
        cell.dateLabel.text = String(purchase.time[range])
        cell.purchaseNameLabel.text = purchase.company.display()
        cell.totalLabel.text = purchase.total.display()
        
        return cell
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new transaction.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let transactionViewController = segue.destination as? TransactionViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedTransactionCell = sender as? TransactionTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "")")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTransactionCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTransaction = purchases[indexPath.row]
            transactionViewController.transaction = selectedTransaction
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
 
}
