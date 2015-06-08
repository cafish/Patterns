//
//  ZoomViewController.swift
//  Patterns
//
//  Created by Jiajia Luo on 6/6/15.
//  Copyright (c) 2015 Jiajia Luo. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var image: NSData? = nil
    var zoomedPattern: Pattern? = nil
    var direction = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // new code...
        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 2
        self.scrollView.delegate = self
        
        self.imageView.image = UIImage(data: self.image!)
        self.scrollView.zoomScale = view.frame.width / imageView.image!.size.width
        self.navigationItem.title = self.direction
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

}


























