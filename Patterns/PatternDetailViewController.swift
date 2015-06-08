//
//  PatternDetailViewController.swift
//  Patterns
//
//  Created by Jiajia Luo on 6/4/15.
//  Copyright (c) 2015 Jiajia Luo. All rights reserved.
//

import UIKit

class PatternDetailViewController: UIViewController {

    var previousViewController = PatternsViewController()
//    var frontImage = NSData()
//    var backImage = NSData()
//    var name = ""
    var pattern : Pattern? = nil
    var tappedImage : NSData? = nil
    var tappedFrontOrBack = ""
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = self.pattern!.name
        self.frontImageView.image = UIImage(data: self.pattern!.frontImage)
        self.backImageView.image = UIImage(data: self.pattern!.backImage)

        var frontTapRecognizer = UITapGestureRecognizer(target: self, action: "frontTapped")
        self.frontImageView.addGestureRecognizer(frontTapRecognizer)
        
        var backTapRecognizer = UITapGestureRecognizer(target: self, action: "backTapped")
        self.backImageView.addGestureRecognizer(backTapRecognizer)
        
    }
    
    func frontTapped() {
        self.tappedImage = self.pattern!.frontImage
        self.tappedFrontOrBack = "Front Image"
        self.performSegueWithIdentifier("zoomSegue", sender: self)
    }
    
    func backTapped() {
        self.tappedImage = self.pattern!.backImage
        self.tappedFrontOrBack = "Back Image"
        self.performSegueWithIdentifier("zoomSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextViewController = segue.destinationViewController as! ZoomViewController
        
        nextViewController.image = self.tappedImage!
        nextViewController.zoomedPattern = self.pattern!
        nextViewController.direction = self.tappedFrontOrBack
        
    }
    

}
