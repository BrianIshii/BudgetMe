//
//  TransactionViewController.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/31/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    var transaction = Purchase()
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(transaction.category.display())

        totalLabel.text = transaction.total.display()
        company.text = transaction.company.display()
        date.text = transaction.time
        
        transaction.total = UnitedStatesCurrency(dollars: 100, cents: 0) ?? UnitedStatesCurrency()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        let isPresentingInEditTransactionMode = presentingViewController is UINavigationController
        
        if isPresentingInEditTransactionMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The TransactionViewController is not inside a navigation controller.")
        }
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
