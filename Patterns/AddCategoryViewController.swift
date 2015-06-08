//
//  AddCategoryViewController.swift
//  Patterns
//
//  Created by Jiajia Luo on 6/7/15.
//  Copyright (c) 2015 Jiajia Luo. All rights reserved.
//

import UIKit
import CoreData

class AddCategoryViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    var previousViewController = PatternCategoryViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // New codes....

    }


    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: context) as! Category
        category.cateName = self.nameTextField.text
        
        category.dateCreated = NSDate()
        
        //        let date = category.dateCreated
        //        let dateFormatter = NSDateFormatter()
        //        dateFormatter.dateStyle = .MediumStyle
        //        dateFormatter.timeStyle = .MediumStyle
        //
        //        let dateText = dateFormatter.stringFromDate(date)
        //        println("dateCreated: \(dateText)")
 
        context.save(nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
