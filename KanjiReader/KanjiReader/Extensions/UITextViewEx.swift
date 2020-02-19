//
//  UITextViewEx.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

extension UITextView {
    
    /// add a toolbar button with customized title, target, and a selector
    func addToolBar(title: String, target: Any, selector: Selector) {
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolbar.setItems([space, barButton], animated: false)
        self.inputAccessoryView = toolbar
    }
}
