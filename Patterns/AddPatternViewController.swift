//
//  AddPatternViewController.swift
//  Patterns
//
//  Created by Jiajia Luo on 6/6/15.
//  Copyright (c) 2015 Jiajia Luo. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class AddPatternViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var frontPicture = true
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var addSelectedCategory: Category? = nil
    
    var previousViewController = PatternsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // New codes...
        imageTapped()
    }

    func imageTapped() {
        var frontTapRecognizer = UITapGestureRecognizer(target: self, action: "frontTapped")
        self.frontImageView.addGestureRecognizer(frontTapRecognizer)
        
        var backTapRecognizer = UITapGestureRecognizer(target: self, action: "backTapped")
        self.backImageView.addGestureRecognizer(backTapRecognizer)
        
    }

    func frontTapped() {
        self.frontPicture = true
        launchCamera()
    }
    
    func backTapped() {
        self.frontPicture = false
        launchCamera()
    }
    
    func launchCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var cameraViewController = UIImagePickerController()
            cameraViewController.sourceType = UIImagePickerControllerSourceType.Camera
            cameraViewController.delegate = self
            self.presentViewController(cameraViewController, animated: true, completion: nil)
            cameraViewController.allowsEditing = true 
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        if self.frontPicture {
            self.frontImageView.image = image
        } else {
            self.backImageView.image = image
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func saveButtonTapped(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var pattern = NSEntityDescription.insertNewObjectForEntityForName("Pattern", inManagedObjectContext: context) as! Pattern
        pattern.name = self.nameTextField.text
        pattern.frontImage = UIImageJPEGRepresentation(self.frontImageView.image, 1)
        pattern.backImage = UIImageJPEGRepresentation(self.backImageView.image, 1)
        
        // need add pattern.category's value in order to filter by category
        pattern.category = self.addSelectedCategory!
        
        context.save(nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    

}
