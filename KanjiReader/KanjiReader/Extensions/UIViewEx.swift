//
//  UIViewEx.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

extension UIView {
    
    /// set isHidden property with an animation
    func setIsHiddenWithAnimation(to isHidden: Bool, duration: TimeInterval = 2) {
        UIView.animate(withDuration: duration, animations: {
            self.isHidden = isHidden
        }, completion: nil)
    }
}
