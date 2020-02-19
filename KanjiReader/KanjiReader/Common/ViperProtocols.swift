//
//  ViperProtocols.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - VIPER Protocols

protocol ViperView {
    associatedtype PresenterType
    var presenter: PresenterType? { get set }
}

protocol ViperInteractor {
//    weak var presenter: ViperPresenter?
}

protocol ViperPresenter {
//    weak var view: ViperView?
    associatedtype InteractorType
    associatedtype RouterType
    var interactor: InteractorType? { get set }
    var router: RouterType? { get set }
}

protocol ViperRouter {
//    weak var view: ViperView?
}
