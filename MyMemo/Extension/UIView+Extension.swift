//
//  UIView+Extension.swift
//  MyMemo
//
//  Created by Donggeun Lee on 2021/11/09.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
