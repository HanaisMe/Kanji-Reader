//
//  Worker.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class Worker {
    
    // MARK: - Worker Singleton
    static let shared = Worker()
    
    // MARK: - APIs
    
    private let converterAPI: ConverterAPI
    private let historyAPI: HistoryAPI
    private init() {
        self.converterAPI = StubbedConverterAPI()
        self.historyAPI = StubbedHistoryAPI()
    }
    
    // MARK: - protocol ConverterAPI
    
    func getRubyCharacters(requestID: String? = nil,
                           sentence: String,
                           outputType: OutputType,
                           success: @escaping (String) -> Void,
                           failure: @escaping (String) -> Void) {
        converterAPI.getRubyCharacters(requestID: requestID, sentence: sentence, outputType: outputType, success: { (convertedSentence) in
                success(convertedSentence)
        }, failure: { (errorMessage) in
                failure(errorMessage)
        })
    }
    
    // MARK: - protocol HistoryAPI
    
    func addHistory(outputType: OutputType,
                    sentence: String,
                    converted: String,
                    success: @escaping () -> Void,
                    failure: @escaping (String) -> Void) {
        historyAPI.addHistory(outputType: outputType, sentence: sentence, converted: converted, success: {
            success()
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
    
    func fetchHistories(success: @escaping ([History]) -> Void,
                        failure: @escaping (String) -> Void) {
        historyAPI.fetchHistories(success: { (histories) in
            success(histories)
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
}
