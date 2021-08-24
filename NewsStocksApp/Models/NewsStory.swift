//
//  NewsStory.swift
//  NewsStocksApp
//
//  Created by Anton Tuzov on 20.08.2021.
//

import Foundation

struct NewsStory: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
//    let id: Int?
    let image: String
    let related, source, summary: String
    let url: String
}

//typealias NewsStories = [NewsStory]




