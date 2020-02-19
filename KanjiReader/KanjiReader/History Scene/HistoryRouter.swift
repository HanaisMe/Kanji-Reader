//
//  HistoryRouter.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class HistoryRouter: ViperRouter {
    
    weak var view: HistoryViewController?
    
    func routeToConverter(with history: History) {
        for vc in (view?.navigationController?.viewControllers ?? []) {
            if let converterVC = vc as? ConverterViewController {
                converterVC.updateView(with: history)
                _ = view?.navigationController?.popToViewController(converterVC, animated: true)
                break
            }
        }
    }
}
