//
//  NewsApi.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/06.
//

import Foundation
import Alamofire

class NewsApi {
    let controller: CalendarViewController
    
    init(controller: CalendarViewController){
        self.controller = controller
    }
    
    func getDataFromNewsApi() {
        let params = [
            "country" : "kr",
            "category" : "business",
            "apiKey" : "ef3b6e61475f4013ad1207771178e4fe"
        ]
        Network.shared.getAPIData(url: "https://newsapi.org/v2/top-headlines", parameters: params, completion: { (data) -> (Void) in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let res = try decoder.decode(EconomyNews.self, from : data)
                
                for i in res.articles{
                    let news = News(i.title, i.url)
                    self.controller.ecoItems.append(news)
                }
              
                self.controller.economyTable.reloadData()
            }catch {
                print(error)
            }
        })
    }
}
