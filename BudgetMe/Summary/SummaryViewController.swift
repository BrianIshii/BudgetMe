//
//  SummaryViewController.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/30/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    var purchases = [Purchase]()
    var fileName = "purchases"
    var total = UnitedStatesCurrency()
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //use the edit button
        navigationItem.leftBarButtonItem = editButtonItem
//        purchases = Purchase.loadPurchasesOrDefault(fileName: fileName)
//        total = UnitedStatesCurrency()
//        for purchase in purchases {
//            total = total.add(other: purchase.total)
//        }
//
//        totalLabel.text = total.display()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        purchases = Purchase.loadPurchasesOrDefault(fileName: fileName)
        
        total = UnitedStatesCurrency()
        for purchase in purchases {
            total = total.add(other: purchase.total)
        }
        
        totalLabel.text = total.display()
    }

}
