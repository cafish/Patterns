# Patterns
Patterns App with CoreData: parent entity and child entity

A few notes:

1. The App was showing an example with CoreData, which has one parent entity (to many) and one child entity (to one)
2. The relationship was set up at Patterns.xcdatamodeld
3. In order to filter the pattern by selected category, when adding new pattern, attribute category of pattern was also added:
        pattern.category = self.addSelectedCategory!
4. The following codes were used to read data from CoreData based on the cretiria: filtering pattern by selected category
override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // read data from core data
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Pattern")
        
        // set up data filtering criteria: Pattern.category == parentEntity
        let pred = NSPredicate(format: "category == %@", self.selectedCategory!)
        request.predicate = pred
        
        
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil {
            self.patterns = results! as! [Pattern]
        }
        
        self.tableView.reloadData()
    }
