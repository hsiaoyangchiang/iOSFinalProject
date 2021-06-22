//
//  CheckViewController.swift
//  finalProject
//
//  Created by 江曉陽 on 2021/6/12.
//

import UIKit
import Firebase
import FirebaseFirestore

class CheckViewController: UIViewController, UIScrollViewDelegate {
    
    //Outlets
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var checkTextView: UITextView!
    @IBOutlet weak var picView: UIImageView!
    
    //Variables
    var year: String = ""
    var month: String = ""
    var date: String = ""
    var mood: String = ""
    var content: String = ""
    var imageurl: String = ""
    var diaryDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        checkTextView.layer.cornerRadius = 17
        checkTextView.isEditable = false
        picView.layer.cornerRadius = 17
        
        //Date Format
        let diaryDate = diaryDateFormat(year: year, month: month, date: date)
        
        //Firebase read all data
        let db = Firestore.firestore()
        db.collection("user").whereField("date", isEqualTo: diaryDate).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let documentData = document.data()
                    
                    let mood = documentData["mood"] as? String ?? "Slightly Smiling Face Emoji"
                    let index:Int? = emojis.firstIndex(where: {$0.name == mood}) ?? 0
                    self.moodImageView.image = emojis[index!].image
                    
                    self.checkTextView.text = documentData["content"] as? String ?? "No content"
                    
                    let imageurl = documentData["imageurl"] as? String ?? ""
                    self.picView.load(urlString: imageurl)
                }
            }
        }
    }
}


extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
