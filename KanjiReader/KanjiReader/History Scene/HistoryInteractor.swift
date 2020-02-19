//
//  HistoryInteractor.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

class HistoryInteractor: NSObject, ViperInteractor {
    
    weak var presenter: HistoryPresenter?
    
    func fetchHistories(success: @escaping ([History]) -> Void,
                        failure: @escaping (String) -> Void) {
        Worker.shared.fetchHistories(success: { (histories) in
            success(histories)
        }, failure: { (errorMessage) in
            failure(errorMessage)
        })
    }
}
