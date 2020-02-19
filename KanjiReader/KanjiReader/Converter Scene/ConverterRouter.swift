//
//  ConverterRouter.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class ConverterRouter: ViperRouter {
    
    weak var view: ConverterViewController?
    
    func routeToHistory() {
        let historyVC = Builder.buildHistoryModule()
        view?.navigationController?.pushViewController(historyVC, animated: true)
    }
}
