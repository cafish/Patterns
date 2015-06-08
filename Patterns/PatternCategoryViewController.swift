//
//  PatternCategoryViewController.swift
//  Patterns
//
//  Created by Jiajia Luo on 6/6/15.
//  Copyright (c) 2015 Jiajia Luo. All rights reserved.
//

import UIKit
import CoreData

class PatternCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var categories : [Category] = []
    var selectedCategory : Category? = nil

    // Step 1: set up tableView dataSoure, delegate;
    // Remember to add UITableViewDataSource and UITableDelegate to protocols
    // Remember to Setup tableView outlet from storyboard to the viewController code
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // After set up the tableView delegate, it will call the methods: tableView:numberOfRowsInSection, tableView:callForRowAtIndexPath
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // read data from core data
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Category")
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil {
            self.categories = results! as! [Category]
        }
        
        self.tableView.reloadData()
    }
    
    // Step 2: define how many cells in the table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    // Step 3: define the contents of the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var category = self.categories[indexPath.row]
        
        // indexPath.row return the row number
        cell.textLabel!.text = category.cateName
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedCategory = self.categories[indexPath.row]
        
        // run the method prepareForSegue:sender:
        self.performSegueWithIdentifier("categoriesToPatternViewSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "categoriesToPatternViewSegue" {
            // Get the new view controller using         segue.destinationViewController
            var nextViewController = segue.destinationViewController as! PatternsViewController
            
            nextViewController.selectedCategory = self.selectedCategory
            
            // Pass the selected object to the new view controller
            nextViewController.previousViewController  = self
        } else {
            var nextViewController = segue.destinationViewController as! AddCategoryViewController
            
            nextViewController.previousViewController = self
        }
    }

}
