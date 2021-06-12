//
//  WritingViewController.swift
//  finalProject
//
//  Created by 江曉陽 on 2021/6/11.
//

import UIKit

class WritingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var contentIng: UIImageView!
    @IBOutlet weak var pickedImg: UIImageView!
    @IBOutlet weak var finishEditBtn: UIButton!
    @IBOutlet weak var textFieldContent: UITextView!
    @IBOutlet weak var EmojiCollectionView: UICollectionView!
    @IBOutlet weak var selectImgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmojiCollectionView.layer.cornerRadius = 17
        EmojiCollectionView.backgroundColor = #colorLiteral(red: 0.8508213758, green: 0.6510567665, blue: 0.4499281049, alpha: 1)
        
        textFieldContent.layer.cornerRadius = 17
        textFieldContent.backgroundColor = #colorLiteral(red: 0.8298953176, green: 0.5993404388, blue: 0.6526073217, alpha: 1)

        selectImgView.layer.cornerRadius = 17
        selectImgView.backgroundColor = #colorLiteral(red: 0.6676806808, green: 0.7581433654, blue: 0.5086507201, alpha: 1)
        
        finishEditBtn.layer.cornerRadius = 15
                                                                
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
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.backgroundColor = nil
    }
    @IBAction func finishEdited(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func selectImg(_ sender: Any) {
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
           if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
               pickedImg.image = editedImage
           }else if let originalImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
               pickedImg.image = originalImage
           }
           dismiss(animated: true, completion: nil)
       }
    
   
    
}
