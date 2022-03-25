//
//  CALayer+Extension.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import Foundation
import UIKit

struct ShadowStyle {
    let color: UIColor
    let x: CGFloat
    let y: CGFloat
    let blur: CGFloat
    let spread: CGFloat

    private init(color: UIColor, x: CGFloat = 0, y: CGFloat = 0, blur: CGFloat = 0, spread: CGFloat = 0) {
        self.color = color
        self.x = x
        self.y = y
        self.blur = blur
        self.spread = spread
    }
}

extension ShadowStyle {
    static var smallUp: ShadowStyle  {
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08)
        return ShadowStyle(color: color, x: 0, y: -2, blur: 4, spread: 0)
    }
}

extension CALayer {
    func makeShadow(style: ShadowStyle) {
        masksToBounds = false
        shadowColor = style.color.cgColor
        shadowOpacity = 1
        shadowOffset = CGSize(width: style.x, height: style.y)
        shadowRadius = style.blur / 2
        if style.spread == 0 {
            shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: -style.spread, dy: -style.spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
