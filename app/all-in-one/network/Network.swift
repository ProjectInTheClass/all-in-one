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
        configuration.httpAdditionalHeaders?["x-access-token"] = "goldapi-9p781ltl4au7z7e-io"
        configuration.httpAdditionalHeaders?["x-api-key"] = "FfVnCRjtlk4p5dJA5Wf668BbgAJKY2Ut5y70nALH"
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
