//
//  Builder.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case history = "History"
}

class Builder {
    
    // MARK: - Common initializer
    
    private static func initiate<T>(from storyboard: Storyboard) -> T {
        let storyboard = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        let className = String(describing: T.self)
        let theVC = storyboard.instantiateViewController(withIdentifier: className) as! T
        return theVC
    }
    
    // MARK: - Scene specific
    
    static func buildConverterModule() -> ConverterViewController {
        let view: ConverterViewController = self.initiate(from: .main)
        let interactor = ConverterInteractor()
        let presenter = ConverterPresenter()
        let router = ConverterRouter()
        // link
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        return view
    }
    
    static func buildHistoryModule() -> HistoryViewController {
        let view: HistoryViewController = self.initiate(from: .history)
        let interactor = HistoryInteractor()
        let presenter = HistoryPresenter()
        let router = HistoryRouter()
        // link
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        return view
    }
}
