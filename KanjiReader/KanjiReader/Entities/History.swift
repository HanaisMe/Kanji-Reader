//
//  History.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation
import RealmSwift

class History: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var outputType = ""
    @objc dynamic var sentence = ""
    @objc dynamic var converted = ""
    @objc dynamic var timestamp = Date().timeIntervalSinceReferenceDate
    
    convenience init(outputType: OutputType, sentence: String, converted: String) {
        self.init()
        self.outputType = outputType.rawValue
        self.sentence = sentence
        self.converted = converted
    }
}
