//
//  ConverterInteractor.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class ConverterInteractor: NSObject, ViperInteractor {
    
    weak var presenter: ConverterPresenter?
    
    func convert(sentence: String,
                 outputType: OutputType,
                 success: @escaping (String) -> Void,
                 failure: @escaping (String) -> Void) {
        Worker.shared.getRubyCharacters(sentence: sentence,
                                        outputType: outputType,
                                        success: { (convertedSentence) in
                                            success(convertedSentence)
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
    
    func addHistory(outputType: OutputType,
                    sentence: String,
                    converted: String,
                    success: @escaping () -> Void,
                    failure: @escaping (String) -> Void) {
        Worker.shared.addHistory(outputType: outputType,
                                 sentence: sentence,
                                 converted: converted,
                                 success: {
                                    success()
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
}
