//
//  Network.swift
//  all-in-one
//
//  Created by 박현준 on 2022/05/26.
//

import Foundation
import Alamofire

class Network {
    static let shared = Network()
    
    static var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [:]
        configuration.httpAdditionalHeaders?["Accept"] = "application/json"
        configuration.httpAdditionalHeaders?["x-access-token"] = "goldapi-496zwwptl3ppdh6l-io"
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    func getAPIData(url: String, parameters : Parameters, completion : @escaping(_ result : Data) -> (Void)){
        let url : String = url
        let parameters : Parameters = parameters
        
        Network.sessionManager.request(url, method: .get, parameters:  parameters).responseJSON { (response) in
            switch response.result{
            case .success(_):
                completion(response.data!)
                break
            case .failure(let error):
                print(error)
                print(response.data!)
                break
            }
        }
    }
}
