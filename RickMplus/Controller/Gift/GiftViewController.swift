//
//  GiftViewController.swift
//  RickM+
//
//  Created by RickSun on 2020/2/2.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher


class GiftViewController: UIViewController {
    
    
    @IBOutlet weak var giftImageCollectionView: UICollectionView!
    @IBOutlet weak var giftImagePageView: UIPageControl!
    @IBOutlet weak var giftProductItemCollectionView: UICollectionView!
    @IBOutlet weak var giftProductListTableView: UITableView!
    
    var imageTest = [
        UIImage(named: "KohTaoSunset"),
        UIImage(named: "PalauJellyfish"),
        UIImage(named: "ThaiTemple")
    ]
    
    var productDataManager = ProductDataManager()
    
    var giftProductItemLabel = ["鼠年必備", "填飽肚子", "解饞零嘴", "來一杯吧", "甜食來襲", "解渴救星"]

    var selectedStatus = [Bool](repeating: false, count: 6)
    
    var timer = Timer()
    var counter = 0
    
    var selectItem: Int = Int()
    
    var productData: AllProduct?
    
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDataManager.delegate = self
        
        productDataManager.getProductData()
        
        giftImageCollectionView.delegate = self
        
        giftImageCollectionView.dataSource = self
        
        giftProductItemCollectionView.delegate = self
        
        giftProductItemCollectionView.dataSource = self
        
        giftProductListTableView.delegate = self
        
        giftProductListTableView.dataSource = self
        
        giftProductListTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        giftImageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        giftImagePageView.numberOfPages = imageTest.count
        
        giftImagePageView.currentPage = 0
        
        DispatchQueue.main.async {
            
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            
        }
        selectedStatus[0] = true
         
    }
    
    
    
    @objc func changeImage() {
        
        if counter < imageTest.count {
            
            let index = IndexPath.init(item: counter, section: 0)
            
            self.giftImageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            giftImagePageView.currentPage = counter
            
            counter += 1
            
        } else {
            
            counter = 0
            
            let index = IndexPath.init(item: counter, section: 0)
            
            self.giftImageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            
            giftImagePageView.currentPage = counter
            
            counter = 1
            
        }
    }
    
}

extension GiftViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.giftImageCollectionView {
            
            return imageTest.count
            
        }
        else if collectionView == self.giftProductItemCollectionView {
            
            return giftProductItemLabel.count
            
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.giftImageCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiftImageCollectionView", for: indexPath) as? GiftImageCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            
            cell.giftSliderImageView.image = imageTest[indexPath.row]
            
            return cell
            
        }
        else if collectionView == self.giftProductItemCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductItemsCollectionView", for: indexPath) as? ProductItemsCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            
            cell.giftProductItemsLable.text = giftProductItemLabel[indexPath.row]
            cell.giftProductItemsLable.layer.borderWidth = 0.5
            cell.giftProductItemsLable.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

            if selectedStatus[indexPath.item] {
                
                cell.contentView.backgroundColor = UIColor(red: 56/255, green: 143/255, blue: 183/255, alpha: 1)
                
            } else {
                
                cell.contentView.backgroundColor = UIColor(red: 92/255, green: 194/255, blue: 194/255, alpha: 1)
                
            }
            
            return cell
    
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.giftImageCollectionView {
            
            let size = giftImageCollectionView.frame.size
            
            return CGSize(width: size.width, height: size.height)
            
        }
        else if collectionView == self.giftProductItemCollectionView {
            
            let size = giftProductItemCollectionView.frame.size
            
            return CGSize(width: 90, height: size.height)
            
        }
        return CGSize(width: 100, height: 60)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.giftProductItemCollectionView {
                         
            selectItem = indexPath.row
            
            selectedStatus = [Bool](repeating: false, count: selectedStatus.count)
            
            selectedStatus[indexPath.row] = true

            self.giftProductItemCollectionView.reloadData()
            
            self.giftProductListTableView.reloadData()
            
        }
    }
}

extension GiftViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let productNumber = productData?.datas[selectItem].product.count  else {
            return 0
        }
        
        return productNumber
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GiftProductListTableViewCell", for: indexPath) as? GiftProductListTableViewCell else {
            
            return UITableViewCell()
           
        }
        if let productInfo = productData?.datas[selectItem].product[indexPath.row] {
                       
                       cell.giftProductListName.text = productInfo.name
                       
                       cell.giftProductPrice.text = String("$ \(productInfo.price)")
                       
                       cell.giftProductListComment.text = productInfo.description
                       
                       cell.giftProductListFeature.text = productInfo.introduction
                       
                       
                       guard let url = URL(string: productInfo.imageUrl) else {
                           return UITableViewCell()
                       }
                       
                       cell.giftProductListImage.kf.setImage(with: url)
                       cell.giftProductListImage.contentMode = .scaleToFill
                       
                   }
                   
                   return cell
        
    }
    

}


extension GiftViewController: ProductDataManagerDelegate {
    func manager(_ manager: ProductDataManager, didgetProductData: AllProduct) {
        
        self.productData = didgetProductData
        
//        print(productData)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.giftProductListTableView.reloadData()
        }
        
        return
    }
    
    func manager(_ manager: ProductDataManager, didFailWith error: Error) {
        return
    }
    

}
