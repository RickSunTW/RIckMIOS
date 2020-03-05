//
//  ChangeStatusViewController.swift
//  RickM+
//
//  Created by RickSun on 2020/2/10.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class ChangeStatusViewController: UIViewController {
    @IBOutlet weak var defaultStatusTableView: UITableView!
    @IBOutlet weak var statusChangeTextField: UITextField!
    
    @IBOutlet weak var selfImage: UIImageView!
    
    @IBAction func upDatedStatusBtnAction(_ sender: UIButton) {
        if statusChangeTextField.text != "" {
            
            if choiceStatus != nil {
                guard let updatedStatus = choiceStatus else {
                    return
                }
                db.collection("Users").document("\(UserInfo.share.logInUserUid)").setData([
                    "status":String("\(updatedStatus)"),
                ], merge: true)
                
            } else {
                guard let updatedStatus = statusChangeTextField.text else {
                    return
                }
                db.collection("Users").document("\(UserInfo.share.logInUserUid)").setData([
                    "status":String("\(updatedStatus)"),
                ], merge: true)
            }
            
            navigationController?.popViewController(animated: true)
        }
        
        return print("error")
        
    }
    
    var choiceStatus: String?
    
    var receiveData : Users?
    
    var defaultStatus = ["忙碌中",
                         "看電影中",
                         "工作中，賺錢要緊",
                         "裝忙中", "睡覺囉，有事等我醒再說",
                         "不方便說話，訊息可",
                         "心情不好中，不想說話",
                         "運動中，人總是要活動活動",
                         "只接緊急來電"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultStatusTableView.dataSource = self
        defaultStatusTableView.delegate = self
     
        if let photoUrl = receiveData?.photoURL {
            guard let url = URL(string: photoUrl) else {
                return
            }
            selfImage.kf.setImage(with: url)
            
        }
        
    }
    
 
    let db = Firestore.firestore()
    func UpdateSelfData() {
        
        db.collection("Users").document("\(UserInfo.share.logInUserUid)").setData([
            "name":"內湖洲子魚",
            "心情":"尚可"
        ], merge: true)
        
    }
    
}

extension ChangeStatusViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultStatus", for: indexPath) as? DefaultStatusTableViewCell else { return UITableViewCell() }
        
        cell.defaultStatusLabel.text = defaultStatus[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choiceStatus = defaultStatus[indexPath.row]
        
        statusChangeTextField.text = choiceStatus
        
    }
    
}
