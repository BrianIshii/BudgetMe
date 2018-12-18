//
//  PurchaseTableViewController.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/18/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import UIKit

class PurchaseTableViewController: UITableViewController {
    var purchases = [Purchase]()
    
    private func loadSamplePurchases() {
        let purchase1 = Purchase(total: UnitedStatesCurrency(dollars: 1, cents: 9) ?? UnitedStatesCurrency(), company: Company(), category: Category(), paymentType: PaymentType())
        
        let purchase2 = Purchase(total: UnitedStatesCurrency(dollars: 10, cents: 99) ?? UnitedStatesCurrency(), company: Company(), category: Category(), paymentType: PaymentType())
        
        let purchase3 = Purchase(total: UnitedStatesCurrency(dollars: 40, cents: 00) ?? UnitedStatesCurrency(), company: Company(), category: Category(), paymentType: PaymentType())
        
        purchases += [purchase1, purchase2, purchase3]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load sample data
        loadSamplePurchases()
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
        
        cell.categoryLabel.text = "category hi"
        cell.dateLabel.text = "12/18"
        cell.purchaseNameLabel.text = "purchase"
        cell.totalLabel.text = purchase.total.display()
        
        return cell
    }
}
