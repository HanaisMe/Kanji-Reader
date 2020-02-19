//
//  ConverterRequest.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

struct ConverterRequest: Codable {
    let appID: String
    let requestID: String?
    let sentence: String
    let outputType: String
    
    enum CodingKeys: String, CodingKey {
        case appID = "app_id"
        case requestID = "request_id"
        case sentence = "sentence"
        case outputType = "output_type"
    }
}
