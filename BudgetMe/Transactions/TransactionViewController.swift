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

    override func viewDidLoad() {
        super.viewDidLoad()
        print(transaction.category.display())

        // Do any additional setup after loading the view.
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
