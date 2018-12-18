//
//  ViewController.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var paymentTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    var selectImage = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        amountTextField.delegate = self
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
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitPurchase(_ sender: UIButton) {
        print("submitted")
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        print("selectImage")
        // Hide the keyboard.
        amountTextField.resignFirstResponder()
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

