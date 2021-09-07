//
//  PManager.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import Foundation

final class PManager {
    static let shared = PManager()
    
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        static let  onBoardedKey = "hasOnBord"
        static let watchListkey = "watchList"
    }
    
    
    
    private init() {}
    

    
    
 //    MARK: - Public
    
   public var watchList: [String] {
    if !hasOnBord {
        userDefaults.set(true, forKey: Constants.onBoardedKey)
        setUpDefaults()
    }

    return userDefaults.stringArray(forKey: Constants.watchListkey) ?? []
    
    }
    
    
    
    
    public func addToWatchList(symbol: String, companyName: String){
        var current = watchList
        current.append(symbol)
        userDefaults.set(current, forKey: Constants.watchListkey)
        
        userDefaults.set(companyName, forKey: symbol)
        
        NotificationCenter.default.post(name: .didAddToWotchList, object: nil)
        
    }
    
    
    
    
    
    public func removeFromWatchList(symbol: String){
        var newList = [String]()
        userDefaults.set(nil, forKey: symbol)
        for item in watchList where item != symbol {
            newList.append(item)
            
        }
        userDefaults.setValue(newList, forKey: Constants.watchListkey)
        
    }
    
    
    
    //    MARK: - Private
    
    private var hasOnBord: Bool {
        
        return userDefaults.bool(forKey: Constants.onBoardedKey)
        
    }
    
    private func setUpDefaults() {
        let map: [String: String] = [
            "AAPL": "Apple inc",
            "MSFT":"Macrosoft",
            "SNAP":"Snap inc",
            "GOOG":"Alphabet",
            "AMZN":"Amozon.com",
            "WORK":"Slack",
            "FB":"Facebook",
            "NVDA":"Nvidia Inc",
            "NKI":"Nike",
            "PINS":"Pinterist"
       
        ]
        
        let symbols = map.keys.map { $0 }
        userDefaults.set(symbols, forKey: Constants.watchListkey)
        
        for (symbols, name) in map {
            userDefaults.set(name, forKey: symbols)
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
