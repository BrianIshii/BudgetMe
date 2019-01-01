//
//  BudgetTableViewController.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/30/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetTableViewController: UITableViewController {
    var budgets = [Budget]()
    var purchases = [Purchase]()


    override func viewDidLoad() {
        super.viewDidLoad()

        budgets += BudgetDatabaseAccess.loadBudgetsOrDefault()
        purchases += PurchaseDatabaseAccess.loadPurchasesOrDefault()

        for purchase in purchases {
            for budget in budgets {
                if (purchase.category.display() == budget.name.display()) {
                    budget.current = budget.current.add(other: purchase.total)
                }
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BudgetTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BudgetTableViewCell else  {
            fatalError("The dequeued cell is not an instance of BudgetTableViewCell.")
        }

        let budget = budgets[indexPath.row]

        cell.budgetName.text = budget.name.display()
        cell.total.text = "\(budget.current.display()) / \(budget.total.display())"
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
