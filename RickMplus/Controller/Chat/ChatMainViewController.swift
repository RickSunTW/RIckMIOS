//
//  ChatMainViewController.swift
//  RickM+
//
//  Created by RickSun on 2020/2/5.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Firebase

class ChatMainViewController: UIViewController {
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBAction func SelectNewChatBtnAction(_ sender: UIButton) {
        
        performSegue(withIdentifier: "SelectNewChat", sender: nil)
        
    }

    @IBAction func sadfasfasfg(_ sender: UIButton) {
        
        print("aaaaa")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        observeMessages()
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    var chatlogForDelete = [Message]()
    var chatLogForChatView = [Message]()
    var chatMessageDictionary = [String: Message]()
    var toId = String()

    func observeMessages() {
        
        
        self.chatLogForChatView.removeAll()
        self.chatMessageDictionary.removeAll()
        self.chatlogForDelete.removeAll()
        
        let db = Firestore.firestore().collection("Message").order(by: "timestamp", descending: false)
        
        
//        .whereField("fromid", isEqualTo: UserInfo.share.logInUserUid)
//        .order(by: "timestamp", descending: false)
        
        db.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                
                print("Error getting documents: \(error)")
                
            } else {
                
                guard let quary = querySnapshot else {
                    
                    return
                    
                }
                
                for document in quary.documents {
                    
                    do {
                        
                        document.data()
                        
                        let chat = try document.data(as: Message.self, decoder: Firestore.Decoder())
                        
                        guard var messageDL = chat else {return}
                        
                        if messageDL.fromid == UserInfo.share.logInUserUid {
                            
                            for searchFriend in 0...(UserInfo.share.friendList.count - 1) {
                                
                                if messageDL.toid == UserInfo.share.friendList[searchFriend].id {
                                    
                                    messageDL.toName = UserInfo.share.friendList[searchFriend].name
                                    
                                    guard let url = URL(string: UserInfo.share.friendList[searchFriend].photoURL!) else { return }
                                    
                                    messageDL.toPhotoUrl = url
                                    
                                    let format = DateFormatter()
                                    
                                    format.dateFormat = "dd/MM hh:mm a"
                                    
                                    let newdate = NSDate(timeIntervalSince1970: messageDL.timestamp!) as Date
                                    
                                    messageDL.timestampString = format.string(from: newdate)
                                    
                                }
                                
                            }
                            
                        } else if messageDL.toid == UserInfo.share.logInUserUid {
                            
                            for searchFriend in 0...(UserInfo.share.friendList.count - 1) {
                                
                                if messageDL.fromid == UserInfo.share.friendList[searchFriend].id {
                                    
                                    messageDL.toName = UserInfo.share.friendList[searchFriend].name
                                    
                                    guard let url = URL(string: UserInfo.share.friendList[searchFriend].photoURL!) else { return }
                                    
                                    messageDL.toPhotoUrl = url
                                    
                                    let format = DateFormatter()
                                    
                                    format.dateFormat = "dd/MM hh:mm a"
                                    
                                    let newdate = NSDate(timeIntervalSince1970: messageDL.timestamp!) as Date
                                    
                                    messageDL.timestampString = format.string(from: newdate)
                                    
                                }
                                
                            }
                            
                        }
                        self.chatlogForDelete.append(messageDL)
                        if messageDL.toid == UserInfo.share.logInUserUid {
                            
                            self.toId = messageDL.fromid!
                            
                            self.chatMessageDictionary[self.toId] = messageDL
                            
                        }
                        else if messageDL.fromid == UserInfo.share.logInUserUid {
                            
                            self.toId = messageDL.toid!
                            
                            self.chatMessageDictionary[self.toId] = messageDL
                            
                        }
                        
                        
                        self.chatLogForChatView = Array(self.chatMessageDictionary.values)
                        
                        self.chatLogForChatView.sort { (message1, message2) -> Bool in
                            
                            guard let time1 = message1.timestamp else { return false }
                            
                            guard let time2 = message2.timestamp else { return false }
                            
                            return time1 > time2
                            
                        }
                        
                    } catch {
                        
                        print(error)
                        
                    }
                }
            }
            
            DispatchQueue.main.async {
                
                self.chatTableView.reloadData()
                
            }
            
        }
    }
    
    func showChatController(user: Users) {
        
        let chatLogControler = ChatLogController(collectionViewLayout: UICollectionViewLayout())
        
        navigationController?.pushViewController(chatLogControler, animated: true)
        
        chatLogControler.user = user
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is SelectNewChatController {
            
            let vc = segue.destination as? SelectNewChatController
            
            vc?.chatHandler = { [weak self] (chat) in
                
                self?.showChatController(user: chat)
                
            }
        }
    }
}

extension ChatMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatLogForChatView.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatUITableVIewCell", for: indexPath) as? ChatListTableViewCell else {
            
            return UITableViewCell()
            
        }
        
        cell.chatListName.text = chatLogForChatView[indexPath.row].toName
        
        cell.chatListLastChat.text = chatLogForChatView[indexPath.row].text
        
        cell.chatListLastDay.text = chatLogForChatView[indexPath.row].timestampString
        
        cell.chatListImage.kf.setImage(with: chatLogForChatView[indexPath.row].toPhotoUrl)
        
        cell.chatListImage.contentMode = .scaleToFill
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let showTheChatName = chatLogForChatView[indexPath.row].toName
        
        for x in 0...(UserInfo.share.friendList.count - 1){
            
            if showTheChatName == UserInfo.share.friendList[x].name {
                
                UserInfo.share.chatRealTimePairUidToFriend = "\(UserInfo.share.friendList[x].id)-\(UserInfo.share.logInUserUid)"
                
                UserInfo.share.chatRealTimePairUidFromMe = "\(UserInfo.share.logInUserUid)-\(UserInfo.share.friendList[x].id)"
                
                self.showChatController(user: UserInfo.share.friendList[x] )
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

             let showTheChatName = chatLogForChatView[indexPath.row].toName

            for x in 0...(UserInfo.share.friendList.count - 1){

                if showTheChatName == UserInfo.share.friendList[x].name {

                    UserInfo.share.chatRealTimePairUidToFriend = "\(UserInfo.share.friendList[x].id)-\(UserInfo.share.logInUserUid)"

                    UserInfo.share.chatRealTimePairUidFromMe = "\(UserInfo.share.logInUserUid)-\(UserInfo.share.friendList[x].id)"

                    //self.showChatController(user: UserInfo.share.friendList[x] )

                }
            }

            for x in 0...(chatlogForDelete.count - 1) {

                if chatlogForDelete[x].chatUid == UserInfo.share.chatRealTimePairUidToFriend {

                    if let deleteMessage = chatlogForDelete[x].chatDocumentUid {
                        let db = Firestore.firestore()
                        db.collection("Message").document("\(deleteMessage)").delete()

                    }


                } else if chatlogForDelete[x].chatUid == UserInfo.share.chatRealTimePairUidFromMe {

                    if let deleteMessage = chatlogForDelete[x].chatDocumentUid {
                        let db = Firestore.firestore()
                        db.collection("Message").document("\(deleteMessage)").delete()

                    }

                }

            }
            
            self.observeMessages()
            
        }

    }
}

