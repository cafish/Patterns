//
//  PatternsViewController.swift
//  Patterns
//
//  Created by Jiajia Luo on 6/4/15.
//  Copyright (c) 2015 Jiajia Luo. All rights reserved.
//

import UIKit
import CoreData

class PatternsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var previousViewController = PatternCategoryViewController()
    
    var patterns : [Pattern] = []
    
    var selectedCategory: Category? = nil
    

    var selectedPattern : Pattern? = nil // define as optional, since it won't exist until we select the cell
    
    // Step 1: set up tableView dataSoure, delegate;
    // Remember to add UITableViewDataSource and UITableDelegate to protocols
    // Remember to Setup tableView outlet from storyboard to the viewController code
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // After set up the tableView delegate, it will call the methods: tableView:numberOfRowsInSection, tableView:callForRowAtIndexPath
        self.navigationItem.title = self.selectedCategory?.cateName
        
        
//        createTestPatterns()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // read data from core data
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Pattern")
        
        // add sorting
        let sd = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sd]
        
        // set up data filtering criteria: Pattern.category == parentEntity
        let pred = NSPredicate(format: "category == %@", self.selectedCategory!)
        request.predicate = pred
        
        
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil {
            self.patterns = results! as! [Pattern]
        }
        
        self.tableView.reloadData()
    }
    
    func createTestPatterns() {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var pattern = NSEntityDescription.insertNewObjectForEntityForName("Pattern", inManagedObjectContext: context) as! Pattern
        pattern.name = "Pants"
        pattern.frontImage = UIImageJPEGRepresentation(UIImage(named: "shirtPattern.jpg"), 1)
        pattern.backImage = UIImageJPEGRepresentation(UIImage(named: "exampleBack.jpg"), 1)
        context.save(nil)
        
    }
    
    // Step 2: define how many cells in the table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patterns.count
    }
    
    // Step 3: define the contents of the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var pattern = self.patterns[indexPath.row]
        println("pattern category name: \(pattern.category.cateName)")
        
        // indexPath.row return the row number
        cell.textLabel!.text = pattern.name
        cell.imageView?.image = UIImage(data: pattern.frontImage)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedPattern = self.patterns[indexPath.row]
    
        // run the method prepareForSegue:sender:
        self.performSegueWithIdentifier("patternsToDetailsSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "patternsToDetailsSegue" {
            // Get the new view controller using         segue.destinationViewController
            var nextViewController = segue.destinationViewController as! PatternDetailViewController
            
            nextViewController.pattern = self.selectedPattern
            
            // Pass the selected object to the new view controller
            nextViewController.previousViewController  = self
        } else {
            var nextViewController = segue.destinationViewController as! AddPatternViewController
            
            nextViewController.addSelectedCategory = self.selectedCategory
            
            nextViewController.previousViewController = self
        }
    }

}

