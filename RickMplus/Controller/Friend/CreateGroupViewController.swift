//
//  CreateGroupViewController.swift
//  RickM+
//
//  Created by RickSun on 2020/2/5.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    

    @IBOutlet weak var buttonImage: UIButton!
    
    @IBAction func setImageBtnAction(_ sender: UIButton) {
        
        let setImageController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "開啟相機拍照", style: .default) { (_) in
            self.camera()
            //info.plist 修改Localization native development region -> $(DEVELOPMENT_LANGUAGE)
        }
        let libraryAction = UIAlertAction(title: "從相簿中選擇", style: .default) { (_) in
            self.photopicker()
        }
        let deleteAction = UIAlertAction(title: "刪除", style: .destructive) { (_) in
            sender.setImage(UIImage(named: "photo"), for: .normal)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        setImageController.addAction(cameraAction)
        setImageController.addAction(libraryAction)
        setImageController.addAction(deleteAction)
        setImageController.addAction(cancelAction)
        present(setImageController, animated: true, completion: nil)
        
    }
    
    @IBAction func setGroupReviewBtn(_ sender: UIButton) {
        let setGroupReviewBtnController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let names = ["自由加入", "密碼驗證", "組長審核"]
        for name in names {
           let action = UIAlertAction(title: name, style: .default) { (action) in
              print("aaa")
           }
           setGroupReviewBtnController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        setGroupReviewBtnController.addAction(cancelAction)
        present(setGroupReviewBtnController, animated: true, completion: nil)
        

    }
    
    func photopicker(){
        
        let photoController = UIImagePickerController()
        photoController.delegate = self
        photoController.sourceType = .photoLibrary
        present(photoController, animated: true, completion: nil)
    }
    func camera(){
        let cameraController = UIImagePickerController()
        cameraController.delegate = self
        cameraController.sourceType = .camera
        present(cameraController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        buttonImage.setImage(image, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonImage.layer.masksToBounds = true
        buttonImage.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }
    

}
