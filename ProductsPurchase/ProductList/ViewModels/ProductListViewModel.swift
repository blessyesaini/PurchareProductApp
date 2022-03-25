//
//  ProductListViewModel.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import UIKit

class ProductListViewModel: NSObject {

    var productResponseData: [ProductsData]?
    var currency: String?
    func getViewData(completion: @escaping(Result<[ProductsListCollectionViewCellModel], Error>)->()){
        var productsDataArray = [ProductsListCollectionViewCellModel]()
        API.shared.getProductListData { result in
            switch result {
               
            case .success(let productsResponse):
                guard let productsData = productsResponse.items else {return}
               print(productsData)
                self.productResponseData = productsData
                for (indexValue,product) in productsData.enumerated() {
                    var amountToDisplayWithCurrency = ""
                    var originalAmountToDisplayWithCurrency = ""
                    if let amount = product.price, let currency = productsResponse.currency {
                        self.currency = currency
                       let amountToDisplay =  amount.withCommas()
                        amountToDisplayWithCurrency = "\(amountToDisplay) \(currency)"
                    }
                    if let amount = product.originalPrice, let currency = productsResponse.currency {
                       let amountToDisplay =  amount.withCommas()
                        originalAmountToDisplayWithCurrency = "\(amountToDisplay) \(currency)"
                    }
                    productsDataArray.append(ProductsListCollectionViewCellModel(idValue: product.id, id: indexValue,name: product.name, productImage: product.image, badges: product.badges, amount: amountToDisplayWithCurrency, brand: product.brand,originalAmount: originalAmountToDisplayWithCurrency))
                }
                completion(.success(productsDataArray))
                break
     
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
