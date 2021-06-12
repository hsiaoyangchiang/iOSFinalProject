//
//  ViewController.swift
//  finalProject
//
//  Created by 江曉陽 on 2021/6/11.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mottoLabel: UILabel!
    @IBOutlet weak var mottoUIView: UIView!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var writingUIView: UIView!
    
    @IBOutlet weak var dateBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mottoUIView.layer.cornerRadius = 17
        writingUIView.layer.cornerRadius = 17
    }
   
    @IBAction func tapAction(_ sender: Any) {
        performSegue(withIdentifier: "goToWritingVC", sender: nil)
    }
    
    @IBAction func checkAction(_ sender: Any) {
        performSegue(withIdentifier: "goToCheckVC", sender: nil)
    }
    
}

