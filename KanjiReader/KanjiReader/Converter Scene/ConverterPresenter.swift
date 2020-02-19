//
//  ConverterPresenter.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class ConverterPresenter: NSObject, ViperPresenter {
    
    typealias InteractorType = ConverterInteractor
    typealias RouterType = ConverterRouter
   
    weak var view: ConverterViewController?
    var interactor: ConverterInteractor?
    var router: ConverterRouter?
    
    func convert(input: String,
                 outputType: OutputType) {
        guard !input.isEmpty else {
            self.view?.updateView(status: .noInput)
            return
        }
        self.view?.updateView(status: .loading, ouputTextViewText: "Loading...")
        
        interactor?.convert(sentence: input,
                            outputType: outputType,
                            success: { [weak self] (result) in
                                self?.view?.updateView(status: .success, ouputTextViewText: result)
        }, failure: { [weak self] (errorMessage) in
            self?.view?.updateView(status: .error, ouputTextViewText: errorMessage)
        })
    }
    
    func addHistory(outputType: OutputType,
                    sentence: String,
                    converted: String) {
        // TODO: - Handle response
        interactor?.addHistory(outputType: outputType,
                               sentence: sentence,
                               converted: converted,
                               success: { () in
                                    print("success")
        }, failure: { (errorMessage) in
            print(errorMessage)
        })
    }
}
