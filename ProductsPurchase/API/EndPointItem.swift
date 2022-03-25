//
//  EndPointItem.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import Foundation
import Alamofire

enum EndPointItem {
    
    // MARK: User actions
    case productList
}
// MARK: - EndPointType
extension EndPointItem : EndPointType {
    
    var headers: HTTPHeaders? {
        switch self {
        case .productList:
            return ["Content-Type": "application/json"]
        }
    }
    
    var baseURL: String {
        return "https://run.mocky.io/v3/"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .productList:
            return .get
      
        }
    }
    var encoding: ParameterEncoding {
        switch self {
        case .productList:
            return URLEncoding.default
      
        }
    }
    
  
  
    var path: String {
        switch self {
        case .productList:
            return "5c138271-d8dd-4112-8fb4-3adb1b7f689e"
        }
    }
    var url: URL {
        switch self {
        case .productList:
            return URL(string: self.baseURL+self.path)!
        }
    }
}
