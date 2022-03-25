//
//  ProductWishListViewModel.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 25/03/2022.
//

import UIKit

class ProductWishListViewModel: NSObject {

    
    func getViewData(currency: String?) -> [WishListTableViewCellModel] {
        var data = [WishListTableViewCellModel]()
        let productsArray = WhishList.shared.productsArray
        var amountToDisplayWithCurrency = ""
        for (indexValue,product) in productsArray.enumerated() {
            if let amount = product.price, let currencyValue = currency {
               let amountToDisplay =  amount.withCommas()
                amountToDisplayWithCurrency = "\(amountToDisplay) \(currencyValue)"
            }
            data.append(WishListTableViewCellModel(idValue: product.id, id: indexValue,name: product.name, productImageURL: product.image, amount: amountToDisplayWithCurrency, brand: product.brand))
        }
        return data
    }
    func getProductsListCollectionViewCellModel(data:WishListTableViewCellModel) -> ProductsListCollectionViewCellModel {
        return ProductsListCollectionViewCellModel(idValue: data.idValue, id: data.id, name: data.name, productImage: data.productImageURL, badges: nil, amount: data.amount, brand: data.brand, originalAmount: nil)
        
    }
}
