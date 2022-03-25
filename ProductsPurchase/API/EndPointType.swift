//
//  EndPointType.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import Foundation
import Alamofire

protocol EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var url: URL { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
    
}
