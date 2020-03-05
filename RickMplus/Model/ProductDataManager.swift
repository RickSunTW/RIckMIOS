//
//  ProductDataManager.swift
//  RickM+
//
//  Created by RickSun on 2020/2/29.
//  Copyright © 2020 RickSun. All rights reserved.
//

import Foundation
import Firebase

protocol ProductDataManagerDelegate: AnyObject {
    
    func manager(_ manager: ProductDataManager, didgetProductData: AllProduct)
    
    func manager(_ manager: ProductDataManager, didFailWith error: Error)
    
}


class ProductDataManager {
    
    weak var delegate: ProductDataManagerDelegate?
    
    let db = Firestore.firestore()

//    func getProductData(completion: @escaping (Result<[Productdata], Error>) -> Void)
    
    func getProductData() {
        db.collection("AllProduct").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
//                var allProduct: AllProduct = []
                
                guard let quary = querySnapshot else {
                    
                    return
                    
                }
                
                for document in quary.documents {
                    
                    do {
                        if let data = try document.data(as: AllProduct.self, decoder: Firestore.Decoder()) {
                            
                            self.delegate?.manager(self, didgetProductData: data)
//                            print(data)
                            
                        }
                        
                    } catch {
                        print(error)
                        return
                    }
                }
//                completion(.success(allProduct))
                
//                self.delegate?.manager(self, didgetProductData: allProduct)
                
            }
        }
    }
    
    
    
}
