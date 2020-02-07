//
//  ViewController.swift
//  MemeMeDraft
//
//  Created by Tamar Auber on 2/5/20.
//  Copyright © 2020 Tamar Auber. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITextFieldDelegate {
    //Setting up outlets
    @IBOutlet weak var albumButtonBottom: UIBarButtonItem!
    @IBOutlet weak var cameraButtonBottom: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cancelButtonTop: UIBarButtonItem!
    @IBOutlet weak var shareButtonTop: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    
    //Struct for meme
    struct Meme {
           var topText: String
           var bottomText: String
           var firstImage: UIImage
           var memedImage: UIImage
       }
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
       startPageReady()
    }
    
    func startPageReady() {
        
        // Add top and bottom text
        
        self.topTextField.text = "TOP"
        self.bottomTextField.text = "BOTTOM"
        self.imageView.image = nil
        
        // Disable share button
        self.shareButtonTop.isEnabled = false
        
        //Camera Button
        self.cameraButtonBottom.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func pickImageFromSource(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
   
    @IBAction func pressCamera(_ sender: Any) {
        pickImageFromSource(sourceType: .camera)
    }
    
    
    @IBAction func pressAction(_ sender: Any) {
        pickImageFromSource(sourceType: .photoLibrary)
    }
}
