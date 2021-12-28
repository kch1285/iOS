//
//  UIViewEx.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/23.
//

import UIKit

extension UIView {
    func setGradient(colors: [CGColor], sx: CGFloat = 1, sy: CGFloat = 0, ex: CGFloat = 0, ey: CGFloat = 1) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.frame = frame
        gradient.startPoint = CGPoint(x: sx, y: sy)
        gradient.endPoint = CGPoint(x: ex, y: ey)
        layer.addSublayer(gradient)
    }
}
