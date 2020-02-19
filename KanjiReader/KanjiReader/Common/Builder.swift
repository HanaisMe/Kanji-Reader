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
    
    static func buildMainScene() -> ConverterViewController {
        let mainVC: ConverterViewController = Builder.initiate(from: .main)
        return mainVC
    }
    
    static func buildHistoryScene() -> HistoryViewController {
        let historyVC: HistoryViewController = Builder.initiate(from: .history)
        return historyVC
    }
}
