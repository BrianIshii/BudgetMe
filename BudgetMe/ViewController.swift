//
//  ViewController.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var paymentTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    
    var selectImage = UITapGestureRecognizer()
    var purchase: Purchase?
    var currency = UnitedStatesCurrency()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        totalTextField.delegate = self
        companyTextField.delegate = self
        categoryTextField.delegate = self
        paymentTextField.delegate = self
        print("viewDidLoad")
        
        // selecting Image
        selectImage = UITapGestureRecognizer(target: self, action: #selector(ViewController.selectImageFromPhotoLibrary(_:)))
        selectImage.numberOfTapsRequired = 1
        selectImage.numberOfTouchesRequired = 1
        photoImageView.addGestureRecognizer(selectImage)
        photoImageView.isUserInteractionEnabled = true
        totalTextField.addTarget(self, action: #selector(totalTextFieldDidChange(_:)), for: .editingChanged)

        updateSaveButtonState()
        currency = UnitedStatesCurrency()
    }
    
    @objc func totalTextFieldDidChange(_ textField: UITextField) {
        textField.text = currency.currencyFormatter(total: textField.text!)
    }
    
    // text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        submitButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let text = totalTextField.text ?? ""
        if (text == "$0.00") {
            submitButton.isEnabled = false
        } else {
            submitButton.isEnabled = true
        }
        print(submitButton.isEnabled)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIButton, button === submitButton else {
            os_log("The submit button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let total = currency.createCurrency(total: totalTextField.text ?? "")
        let company = Company(name: companyTextField.text ?? "")
        let category = PurchaseCategory(name: categoryTextField.text ?? "", color: "orange")
        let paymentType = PaymentType()
        
        purchase = Purchase(total: total, company: company, category: category, paymentType: paymentType)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        print("selectImage")
        // Hide the keyboard.
        totalTextField.resignFirstResponder()
//        companyTextField.resignFirstResponder()
//        categoryTextField.resignFirstResponder()
//        paymentTextField.resignFirstResponder()

        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        print("Cancel")
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("pick image")
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        print("pick image")

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}

