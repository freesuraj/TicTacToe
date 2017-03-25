//
//  UIViewExtension.swift
//  TTT
//
//  Created by Suraj Pathak on 25/3/17.
//  Copyright © 2017 Suraj. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setAnimatedText(_ text: String, color: UIColor? = nil) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = 0.75
        layer.add(animation, forKey: kCATransitionFade)
        self.text = text
        if let color = color { textColor = color }
    }
    
    func highlight(color: UIColor) {
        textColor = color
        let colorAnimation = CABasicAnimation(keyPath: "borderColor")
        colorAnimation.fromValue = UIColor.clear.cgColor
        colorAnimation.toValue = color.cgColor
        layer.borderColor = color.cgColor
        
        let widthAnimation = CABasicAnimation(keyPath: "borderWidth")
        widthAnimation.fromValue = 1
        widthAnimation.toValue = 3
        widthAnimation.duration = 0.6
        layer.borderWidth = 3
        
        let bothAnimations = CAAnimationGroup()
        bothAnimations.duration = 0.5
        bothAnimations.animations = [colorAnimation, widthAnimation]
        bothAnimations.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        layer.add(bothAnimations, forKey: "color and width")
    }
    
    func unhighlight() {
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor
        textColor = .black
    }
    
}
