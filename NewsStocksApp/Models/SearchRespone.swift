//
//  SearchRespone.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import Foundation



// MARK: - SearchRespons
struct SearchRespone: Codable {
    let count: Int?
    let result: [SResult]
}

// MARK: - Result
struct SResult: Codable {
    
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String


}

