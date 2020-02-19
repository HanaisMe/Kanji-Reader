//
//  OutputType.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

enum OutputType: String {
    case hiragana = "hiragana"
    case katakana = "katakana"
    
    var displayName: String {
        switch self {
        case .hiragana:
            return "ひらがな"
        case .katakana:
            return "カタカナ"
        }
    }
}
