//
//  Pattern.swift
//  Patterns
//
//  Created by Jiajia Luo on 6/7/15.
//  Copyright (c) 2015 Jiajia Luo. All rights reserved.
//

import Foundation
import CoreData

class Pattern: NSManagedObject {

    @NSManaged var backImage: NSData
    @NSManaged var dateCreated: NSDate
    @NSManaged var frontImage: NSData
    @NSManaged var name: String
    @NSManaged var category: Category

}
