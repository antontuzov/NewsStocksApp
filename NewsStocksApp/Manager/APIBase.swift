//
//  APIBase.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import Foundation

final class APIBase {
    
    static let shared = APIBase()
    
    
//    MARK: - Public
    
    private struct Constants {
        static let apikey = "c3r69giad3i98m4iihgg"
        static let sandboxUrlBaseKey = "sandbox_c3r69giad3i98m4iihh0"
        static let baseUrlkey = "https://finnhub.io/api/v1/"
        static let day: TimeInterval = 3600 * 24
    }
    
    
    private init() {}
    
    

    public func search(query: String,
                       completopn: @escaping (Result<SearchRespone, Error>) -> Void

    ) {
        
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return }
        
        
       request(url: url(
                for: .search,
                queryPorams: ["q": safeQuery]), expecting: SearchRespone.self, completion: completopn)

    }

//    public func news(for type: NewsViewController.`Type`,
//                     completion: @escaping (Result<[NewsStory], Error>) -> Void) {
//
////         let url = url(for: .topStories, queryPorams: ["category":"general"])
//
////        request(url: url(for: .topStories, queryPorams: ["category":"general"]),
////                expecting: [NewsStory].self, completion: completion)
//
//
//        switch type {
//        case .topStories:
//            request(url: url(for: .topStories, queryPorams: ["category":"general"]),
//                    expecting: [NewsStory].self, completion: completion)
//
//        case .compan(let symbol):
//            let today = Date()
//            let oneMonthBack = today.addingTimeInterval(-(Constants.day * 7))
//
//            request(url: url(for: .companyNews,
//                             queryPorams: ["symbol": symbol,
//                                           "from": DateFormatter.newsDateFormatter.string(from: oneMonthBack),
//                                           "to": DateFormatter.newsDateFormatter.string(from: today)
//                             ]),
//                    expecting: [NewsStory].self, completion: completion)
//        }
//
//
//
//
//    }
    
    
    
    public func marketData(for symbol: String, numberOfDays: TimeInterval = 7,
                           completion: @escaping (Result< MarketDataResponse, Error>) -> Void){
        
        
        
        let today = Date().addingTimeInterval(-(Constants.day))
        let prior = today.addingTimeInterval(-(Constants.day * numberOfDays))
        
        
        
        let url = url(for: .marketData, queryPorams: [
            
            "symbol": symbol,
            "resolution": "1",
            "from": "\(Int(prior.timeIntervalSince1970))",
            "to": "\(Int(today.timeIntervalSince1970))"
        
        ])
        
        
        request(url: url, expecting:  MarketDataResponse.self, completion: completion)
        
        
        
    }
    
    
    
    
    
    
    //    MARK: - Private
    
    private enum endpoint: String {
        case search
        case topStories = "news"
        case companyNews = "company-news"
        case marketData = "stock/candle"
    }
    
    private enum APIError: Error {
        case invalidUrlError
        case unknowError
    }
    
    
    
    private func url(for endpoingt: endpoint,
                     queryPorams: [String:String] = [:]) -> URL?{
        
        
        
        var urlString = Constants.baseUrlkey + endpoingt.rawValue
        
//        add any param
        var queryItems = [URLQueryItem]()
        
        for (name, value) in queryPorams {
            queryItems.append(.init(name: name, value: value))
            
        }
        
        
        
        
        
        
        queryItems.append(.init(name: "token", value: Constants.apikey))
        
        
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "" )"}.joined(separator: "&")
        
        
        print("\n\(urlString)\n")
        
        
        return URL(string: urlString)
    }
    
    
    private func request< T : Codable>(url: URL?,
                                     expecting: T.Type,
                                     completion: @escaping (Result<T , Error>) -> Void){

        guard let url = url else {

            completion(.failure(APIError.invalidUrlError))
            return

        }

        let task =  URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {

                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.unknowError))
                    
                    
                    
                    
                }


                return
            }

            do {

                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))

            } catch {

                completion(.failure(error))

            }





        }
          task.resume()



    }







    
    
    
    
    
    
}

