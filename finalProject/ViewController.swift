//
//  ViewController.swift
//  finalProject
//
//  Created by 江曉陽 on 2021/6/11.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {

<<<<<<< Updated upstream
    
=======
    //Outlets
    @IBOutlet var viewBackground: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var placeholder: UILabel!
    @IBOutlet weak var mottoTextField: UITextView!
>>>>>>> Stashed changes
    @IBOutlet weak var mottoLabel: UILabel!
    @IBOutlet weak var mottoUIView: UIView!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var writingUIView: UIView!
<<<<<<< Updated upstream
    
    @IBOutlet weak var dateBtn: UIButton!
=======
    @IBOutlet weak var monthLabel: UILabel!

    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var previous: UIButton!

    var selectedDate = Date()
    var totalSquares = [String]()
    var today = Date()
    var dateFormatter = DateFormatter()
    
>>>>>>> Stashed changes
    override func viewDidLoad() {
        super.viewDidLoad()
        mottoUIView.layer.cornerRadius = 17
        writingUIView.layer.cornerRadius = 17
<<<<<<< Updated upstream
    }
   
=======
        collectionView.layer.cornerRadius = 17
        mottoTextField.font = UIFont(name: "Homenaje-Regular", size: 20)
        mottoTextField.isEditable = false
        
        setCellsView()
        setMonthView()
        randomString()
        
        //判斷今天的日期有沒有建立日記
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayDate = dateFormatter.string(from: today)
        
        let db = Firestore.firestore()
        let docRef = db.collection("user").document("todayDate");
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.placeholder.text = "Rewrite Something"
                self.viewBackground.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.6980392157, blue: 0.8509803922, alpha: 1)
            } else {
                print("There is no record of today's diary")
            }
        }
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width,height:height)
    }
    
    //Calendar Collection View
    func setMonthView()
    {
        totalSquares.removeAll()

        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)

        var count: Int = 1
        while(count <= 42)
        {
            if (count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append("")
            }
            else
            {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"calCell", for: indexPath) as! CalendarCollectionViewCell
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        //print("Total Squares: \(totalSquares[indexPath.item])")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let diaryDate = diaryDateFormat(year: CalendarHelper().yearString(date: selectedDate), month: CalendarHelper().monthString(date: selectedDate), date: totalSquares[indexPath.item])
        //print("Diary Date MainVC: \(diaryDate)")
        
        //判斷點去的日期是不是有資料的
        let db = Firestore.firestore()
        let docRef = db.collection("user").document(diaryDate);
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.performSegue(withIdentifier: "viewRecord", sender: indexPath)
            } else {
                print("Document does not exist")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewRecord" {
            let selectedIndexPath = sender as? NSIndexPath
            let vc = segue.destination as! CheckViewController
            vc.year = CalendarHelper().yearString(date: selectedDate)
            vc.month = CalendarHelper().monthString(date: selectedDate)
            vc.date = totalSquares[selectedIndexPath!.item] as String
            //print("Selected: \(totalSquares[selectedIndexPath!.item])")
        }
    }
    
    //心靈雞湯
    func randomString(){
        let array = ["Life is better when you smile :)",
                     "The key to being happy is knowing you have the power to choose what to accept and what to let go.",
                     "There are so many beautiful reasons to be happy.",
                     "You didn't come this far to only come this far.",
                     "Your only limit is your mind.",
                     "It's okay to struggle but it's not okay to give up.",
                     "Feel what you need to feel and then let it go. Do not let it consume you.",
                     "Do something today that your future self will thank you for."]
        mottoTextField.text = array.randomElement()
    }

    //連結到發文頁面
>>>>>>> Stashed changes
    @IBAction func tapAction(_ sender: Any) {
        performSegue(withIdentifier: "goToWritingVC", sender: nil)
    }
    
<<<<<<< Updated upstream
    @IBAction func checkAction(_ sender: Any) {
        performSegue(withIdentifier: "goToCheckVC", sender: nil)
=======
    //上個月
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    //下個月
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    override open var shouldAutorotate: Bool
    {
        return false
>>>>>>> Stashed changes
    }
    
}
