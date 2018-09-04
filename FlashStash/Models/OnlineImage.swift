//
//  OnlineImage.swift
//  FlashStash
//
//  Created by Adam on 02/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation

struct TopLevelData: Codable {
    let value: [ImageSearchResult]
}

struct ImageSearchResult: Codable {
    let url: String
    let thumbnail: String
}
