//
//  ConverterResponse.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

struct ConverterResponse: Codable {
    let converted: String
    let outputType: String
    let requestID: String
    
    enum CodingKeys: String, CodingKey {
        case converted = "converted"
        case outputType = "output_type"
        case requestID = "request_id"
    }
}
