//
//  ChatMessageCellCollectionViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/2/24.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import AVFoundation

class ChatMessageCellCollectionViewCell: UICollectionViewCell {
    
    var chatLogController: ChatLogController?
    
    var message: Message?
    
    //需要修正一下寫法
    
    let activityIndicatorView: UIActivityIndicatorView = {
        
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        
        aiv.translatesAutoresizingMaskIntoConstraints = false
        
        aiv.hidesWhenStopped = true
        
        return aiv
    }()
    
    lazy var playButton: UIButton = {
        
         let button = UIButton(type: .system)
          
        let image = UIImage(systemName: "play.fill")
        
        button.setImage(image, for: .normal)
        
        button.tintColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        
        return button
    }()
    
    var playerLayer: AVPlayerLayer?
    
    var player: AVPlayer?
    
    @objc func handlePlay() {
        
        if let videoUrlString = message?.videoUrl, let url = URL(string: videoUrlString) {
            
            player = AVPlayer(url: url)
            
            playerLayer = AVPlayerLayer(player: player)
            
            playerLayer?.frame = bubbleView.bounds
            
            bubbleView.layer.addSublayer(playerLayer!)
            
            player?.play()
            
            activityIndicatorView.startAnimating()
            
            playButton.isHidden = true
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playerLayer?.removeFromSuperlayer()
        
        player?.pause()
        
        activityIndicatorView.stopAnimating()
        
    }
    
    
    let textView: UITextView = {
        let tv = UITextView()
        
        tv.text = "SAMPLE TEXT FOR NOW"
        
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        
        tv.backgroundColor = UIColor.clear
        
        tv.textColor = .white
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        tv.isEditable = false
        
        return tv
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 0/255, green: 137/255, blue: 249/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        return view
    }()
    
    var profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 8 
        
        imageView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    lazy var messageImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 16
        
        imageView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomTap)))
        
        return imageView
        
    }()
    
    @objc func handleZoomTap(tapGesture: UITapGestureRecognizer) {
        
        if message?.videoUrl != nil {
            return
        }
        
        
        guard let imageView = tapGesture.view as? UIImageView else {
            return
        }
        
        self.chatLogController?.performZoomInForStartingImageView(startingImageView: imageView)
        
    }
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = UIColor.red
        
        clipsToBounds = true
        
        self.addSubview(bubbleView)
        self.addSubview(textView)
        self.addSubview(profileImageView)
        bubbleView.addSubview(messageImageView)
        
        messageImageView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor).isActive = true
        messageImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        messageImageView.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
        messageImageView.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
        
        bubbleView.addSubview(playButton)
        
        playButton.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bubbleView.addSubview(activityIndicatorView)
         
         activityIndicatorView.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor).isActive = true
         activityIndicatorView.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor).isActive = true
         activityIndicatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
         activityIndicatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleViewRightAnchor?.isActive = true
        
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50)
        bubbleViewLeftAnchor?.isActive = true
        
//        bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
 
    }
    
}
