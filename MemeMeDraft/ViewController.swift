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

    @IBOutlet weak var navBar: UINavigationBar!
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
 
 
    

    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .font:  UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .foregroundColor: UIColor.white,
        .strokeWidth: -4.0,
        .strokeColor: UIColor.black
    ]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       startPageReady()
    }
    
    func startPageReady() {
        self.bottomTextField.text = "BOTTOM"
        self.topTextField.text = "TOP"
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.shareButtonTop.isEnabled = false
        self.cameraButtonBottom.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
  //Helper function
    func hideToolBar(showOption: Bool) {
        self.bottomToolbar.isHidden = showOption
        self.navBar.isHidden = showOption
    }
    
    func generateImage() -> UIImage {
           
           hideToolBar(showOption: true)
           
           UIGraphicsBeginImageContext(self.view.frame.size)
           view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
           let generatedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
           UIGraphicsEndImageContext()

           hideToolBar(showOption: false)
           
           return generatedImage
       }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          
          if let image = info[.editedImage] as? UIImage {
              self.shareButtonTop.isEnabled = true
              imageView.image = image
              imageView.contentMode = .scaleAspectFill
              
          } else if let image = info[.originalImage] as? UIImage {
              self.shareButtonTop.isEnabled = true
            imageView.image = image
              imageView.contentMode = .scaleAspectFit
              
          }
          dismiss(animated: true, completion: nil)
      }
    
     // func textFieldResignFirstResponder(_ textField: UITextField) -> Bool {
      //      textField.resignFirstResponder()
       //     return true
       // }

        @objc func keyboardWillShow(_ notification:Notification) {
            if bottomTextField.isEditing{
            view.frame.origin.y = -getKeyboardHeight(notification)
            }
        }
        
        @objc func keyboardWillHide(_ notification:Notification) {
            view.frame.origin.y = 0.0
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.topTextField.resignFirstResponder()
            self.bottomTextField.resignFirstResponder()
        }
        
        func getKeyboardHeight(_ notification:Notification) -> CGFloat {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            return keyboardSize.cgRectValue.height
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
    
  func shareMeme( _ memeImageToShare: UIImage) {
    _ = Meme(topText: self.topTextField.text!,
             bottomText: self.bottomTextField.text!,
             firstImage: self.imageView.image!,
             memedImage: memeImageToShare)
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func pressShare(_ sender: Any) {
        let memeImageToSave = generateImage()
        let activityController = UIActivityViewController(activityItems: [memeImageToSave], applicationActivities: nil)
            activityController.completionWithItemsHandler = {
                activity, completed, item, error in
                if completed {
                    self .shareMeme(memeImageToSave)
                    self.dismiss(animated: true, completion: nil)
                }
            }
            present(activityController, animated: true, completion: nil)
        }
    
    @IBAction func pressCancel(_ sender: Any) {
        self.startPageReady()
    }
    @IBAction func pressAction(_ sender: Any) {
        pickImageFromSource(sourceType: .photoLibrary)
    }

}
