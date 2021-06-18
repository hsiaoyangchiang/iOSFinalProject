//
//  ViewController.swift
//  finalProject
//
//  Created by 江曉陽 on 2021/6/11.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mottoTextField: UITextView!
    @IBOutlet weak var mottoLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var writingUIView: UIView!
    @IBOutlet weak var monthLabel: UILabel!




    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var previous: UIButton!




    var selectedDate = Date()
    var totalSquares = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mottoTextField.layer.cornerRadius = 17
        writingUIView.layer.cornerRadius = 17
        collectionView.layer.cornerRadius = 17
        mottoTextField.font = UIFont(name: "Homenaje-Regular", size: 20)
        mottoTextField.isEditable = false
        

        setCellsView()
        setMonthView()
        randomString()
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width,height:height)
    }
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
        return cell
    }

    func randomString(){
        let array = ["Life is better when you smile :)","The key to being happy is knowing you have the power to choose what to accept and what to let go.","There are so many beautiful reasons to be happy.","You didn't come this far to only come this far.","Your only limit is your mind.","It's okay to struggle but it's not okay to give up.","Feel what you need to feel and then let it go. Do not let it consume you.","Do something today that your future self will thank you for."]
        mottoTextField.text = array.randomElement()
    }

   
    @IBAction func tapAction(_ sender: Any) {
        performSegue(withIdentifier: "goToWritingVC", sender: nil)
    }
    

    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    override open var shouldAutorotate: Bool
    {
        return false
    }
}

