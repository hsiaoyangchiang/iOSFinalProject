//
//  CheckViewController.swift
//  finalProject
//
//  Created by 江曉陽 on 2021/6/12.
//

import UIKit

class CheckViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var checkTextView: UITextView!
    
    @IBOutlet weak var picView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        checkTextView.layer.cornerRadius = 17
        checkTextView.isEditable = false
        
        picView.layer.cornerRadius = 17
        
    }
    

    

}



