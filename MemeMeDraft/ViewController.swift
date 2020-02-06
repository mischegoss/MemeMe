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
    
 
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var topToolbar: UIToolbar!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

