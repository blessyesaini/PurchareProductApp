//
//  API.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import Foundation
import Alamofire
class API: NSObject {

static let shared = API()
        
    func getProductListData(completion: @escaping(Result<ProductsResponse, Error>)->()) {
        APIManager.shared().call(type: EndPointItem.productList, params: nil) { (result:Swift.Result<ProductsResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
