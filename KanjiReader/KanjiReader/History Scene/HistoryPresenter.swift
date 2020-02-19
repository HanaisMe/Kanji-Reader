//
//  HistoryPresenter.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class HistoryPresenter: NSObject, ViperPresenter {
    
    typealias InteractorType = HistoryInteractor
    typealias RouterType = HistoryRouter
   
    weak var view: HistoryViewController?
    var interactor: HistoryInteractor?
    var router: HistoryRouter?
    
    var histories = [History]()
    
    func fetchHistories() {
        interactor?.fetchHistories(success: { [weak self] (histories) in
            self?.histories = histories
            self?.view?.reloadData()
        }, failure: { (errorMessage) in
            // TODO: - handle error
            print(errorMessage)
        })
    }
    
    func selectHistory(at: Int) {
        router?.routeToConverter(with: histories[at])
    }
}
