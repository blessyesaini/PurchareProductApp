//
//  WhishList.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import UIKit

class WhishList: NSObject {

    static let shared = WhishList()
    var isItemSelected: Bool? = false
    var productsArray = [ProductsData]()
    
    func addProductToWhishList(product: ProductsData) {
        if let index = productsArray.firstIndex(where: { $0.id ==
            product.id
        }) {
            productsArray.remove(at: index)
            productsArray.append(product)
        }
        else {
            productsArray.append(product)
        }
       
    }
    func removeProductToWhishList(product: ProductsData) {
        if let index = productsArray.firstIndex(where: { $0.id ==
            product.id
        }) {
            productsArray.remove(at: index)
        }
       
       
    }
   
}
