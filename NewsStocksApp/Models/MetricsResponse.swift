//
//  MetricsResponse.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import Foundation


struct MetricsResponse: Codable {
    let metric: Metrics?
    
}




struct Metrics: Codable {
    let TenDayAverageTradingVolume: Float
    let AnnualWeekHigh: Double
    let AnnualWeekLow:  Double
    let AnnualWeekLowDate: String
    let AnnualWeekPriceReturnDaily: Double
    let beta: Float?
    
    enum CodingKeys: String, CodingKey {
        case TenDayAverageTradingVolume = "10DayAverageTradingVolume"
        case AnnualWeekHigh = "52WeekHigh"
        case AnnualWeekLow = "52WeekLow"
        case AnnualWeekLowDate = "52WeekLowDate"
        case AnnualWeekPriceReturnDaily = "52WeekPriceReturnDaily"
        case beta = ""
        
        
        
        
    }
    
}

