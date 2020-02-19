//
//  HistoryAPI.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - protocol HistoryAPI
protocol HistoryAPI {
    func addHistory(outputType: OutputType,
                    sentence: String,
                    converted: String,
                    success: @escaping () -> Void,
                    failure: @escaping (String) -> Void)
    
    func fetchHistories(success: @escaping ([History]) -> Void,
                        failure: @escaping (String) -> Void)
}

class StubbedHistoryAPI: HistoryAPI {
    
    /// add a history
    func addHistory(outputType: OutputType,
                    sentence: String,
                    converted: String,
                    success: @escaping () -> Void,
                    failure: @escaping (String) -> Void) {
        let record = History(outputType: outputType, sentence: sentence, converted: converted)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(record)
            }
            success()
        } catch {
            failure(error.localizedDescription)
        }
    }
    
    /// fetch stored histories
    func fetchHistories(success: @escaping ([History]) -> Void,
                        failure: @escaping (String) -> Void) {
        do {
            let realm = try Realm()
            let results: Results<History> = realm.objects(History.self)
            success(Array(results))
        } catch {
            failure(error.localizedDescription)
        }
    }
}
