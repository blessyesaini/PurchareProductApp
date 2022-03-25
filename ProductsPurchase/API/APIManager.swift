//
//  APIManager.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import Foundation
import Alamofire
class APIManager: NSObject {
    
    // MARK: - Vars & Lets
    
    private let sessionManager: Session
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: Session())
        
        return apiManager
    }()
    class func shared() -> APIManager {
        return sharedApiManager
    }
    // MARK: - Initialization
    
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (Swift.Result<T, Error>) -> Void) where T: Codable {
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { (data) in
                                        switch data.result {
                                        case .success(_):
                                            let decoder = JSONDecoder()
                                                if let jsonData = data.data
                                                {
                                                    // Do Catch Starts Here
                                                    do
                                                    {
                                                        let result = try decoder.decode(T.self, from: jsonData)
                                                        handler(.success(result))
                                                    }
                                                    catch
                                                    {
                                                        // Inspect any thrown errors here.
                                                        print(String(describing: error))
                                                 
                                                        print(error)
                                                        handler(.failure(error))
                                                    }
                                                    // Do Catch Ends Here
                                                }
                                            

                                            break
                                        case .failure(let error):
                                            print(String(describing: error))
                                        
                                            break
                                        }
        }
}
   
}
