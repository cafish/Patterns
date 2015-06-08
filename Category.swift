//
//  Category.swift
//  Patterns
//
//  Created by Jiajia Luo on 6/7/15.
//  Copyright (c) 2015 Jiajia Luo. All rights reserved.
//

import Foundation
import CoreData

class Category: NSManagedObject {

    @NSManaged var cateName: String
    @NSManaged var dateCreated: NSDate
    @NSManaged var pattern: NSSet

}
