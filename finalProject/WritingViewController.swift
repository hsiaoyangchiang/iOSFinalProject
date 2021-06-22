//
//  WritingViewController.swift
//  finalProject
//
//  Created by 江曉陽 on 2021/6/11.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class WritingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var contentIng: UIImageView!
    @IBOutlet weak var pickedImg: UIImageView!
    @IBOutlet weak var uploadPicBtn: UIButton!
    @IBOutlet weak var finishEditBtn: UIButton!
    @IBOutlet weak var textFieldContent: UITextView!
    @IBOutlet weak var EmojiCollectionView: UICollectionView!
    @IBOutlet weak var selectImgView: UIView!
    
    //Variables
    let today = Date()
    let dateFormatter = DateFormatter()
    private let storage = Storage.storage().reference()
    struct myVariables {
        static var mood = ""
        static var urlString = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmojiCollectionView.layer.cornerRadius = 17
        EmojiCollectionView.backgroundColor = #colorLiteral(red: 0.8508213758, green: 0.6510567665, blue: 0.4499281049, alpha: 1)
        
        textFieldContent.layer.cornerRadius = 17
        textFieldContent.backgroundColor = #colorLiteral(red: 0.8298953176, green: 0.5993404388, blue: 0.6526073217, alpha: 1)

        selectImgView.layer.cornerRadius = 17
        selectImgView.backgroundColor = #colorLiteral(red: 0.6676806808, green: 0.7581433654, blue: 0.5086507201, alpha: 1)
        
        finishEditBtn.layer.cornerRadius = 15
        uploadPicBtn.layer.cornerRadius = 15
        
        EmojiCollectionView.delegate = self
        EmojiCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = EmojiCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EmojisCollectionViewCell
        cell.setup(with: emojis[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.backgroundColor = #colorLiteral(red: 0.5677035899, green: 0.4354302234, blue: 0.2968391927, alpha: 1)
        cell?.layer.cornerRadius = 15
        print(emojis[indexPath.row].name)
        myVariables.mood = emojis[indexPath.row].name
        UserDefaults.standard.set(myVariables.mood, forKey: "mood")
        print("Selected Mood: \(myVariables.mood)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.backgroundColor = nil
    }
    
    @IBAction func selectImg(_ sender: Any) {
        showImagePickerController()
    }
    
    @IBAction func uploadPic(_ sender: Any) {
        showImagePickerController()
    }
    
    func showImagePickerController(){
           let imagePickerController = UIImagePickerController()
           imagePickerController.delegate = self
           imagePickerController.allowsEditing = true
           imagePickerController.sourceType = .photoLibrary
           present(imagePickerController, animated: true, completion: nil )
       }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /*
           if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
               pickedImg.image = editedImage
           }else if let originalImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
               pickedImg.image = originalImage
           }
           dismiss(animated: true, completion: nil)*/
        
        dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        
        pickedImg.image = image
        
        //upload image to db
        //get download url
        //save download url to user default
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: today)
        
        storage.child("images/file\(date).png").putData(imageData, metadata: nil, completion: { _, error in
            guard error == nil else {
                print("failed to upload")
                return
            }
<<<<<<< Updated upstream
            
            self.storage.child("images/file.png").downloadURL(completion: { url, error in
=======

            self.storage.child("images/file\(date).png").downloadURL(completion: { url, error in
>>>>>>> Stashed changes
                guard let url = url, error == nil else {
                    return
                }
                myVariables.urlString = url.absoluteString
                UserDefaults.standard.set(myVariables.urlString, forKey: "url")
                print("Download URL: \(myVariables.urlString)")
            })
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { //cancel picking
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "How're you feeling", message: "What will you fill your mood cup with today", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "I see", style: .cancel, handler: { action in
            print("tapped")
        }))
        present(alert, animated: true)
    }
    
    @IBAction func finishEdited(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
        let db = Firestore.firestore()
        
        //Get today date
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: today)
        
        //Get data
        let content = textFieldContent.text
        let mood = myVariables.mood
        let url = myVariables.urlString
        print("the url to upload to db: \(url)") //Make sure there is an url for the image
        
        guard mood != "" else {
            showAlert()
            return
        }
        
        //Upload data to Firebase
        db.collection("user").document(date).setData(["date":date,"content":content!,"mood":mood,"imageurl":url])
<<<<<<< Updated upstream
        self.performSegue(withIdentifier: "backToMain", sender: nil)
=======
        self.performSegue(withIdentifier: "finishWriting", sender: nil)
>>>>>>> Stashed changes
    }
    
    
}
