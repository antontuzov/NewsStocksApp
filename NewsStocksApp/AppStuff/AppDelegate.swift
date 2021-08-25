//
//  AppDelegate.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
//                APIBase.shared.search(query: "Apple") { result in
//                    switch result {
//                    case .success(let response):
//                        print(response.result)
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
        //
        //        APIBase.shared.news(for: .compan(symbol: "MSFT")) { result in
        //            switch result {
        //            case .success(let news):
        //                print(news.count)
        //            case .failure: break
        //            }
        //        }
                

        //        APIBase.shared.marketData(for: "AAPL") { result in
        //            switch result {
        //            case .success(let data):
        //                let candleSticks = data.candleSticks
        //            case .failure(let error):
        //                print(error)
        //            }
        //
        //
        //
        //
        //
        //        }

        
        
        
        
        
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

