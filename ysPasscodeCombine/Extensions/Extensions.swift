//
//  Extensions.swift
//  ysPasscodeCombine
//
//  Created by Ярослав on 06.02.2022.
//

import UIKit
import AudioToolbox

extension UIView {
    func shake(withVibration: Bool = true, count: Float = 2, for duration: TimeInterval = 0.15, withTranslation translation: Float = 7, withCompletion completion: (() -> Void)? = nil) {
        if withVibration {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
}
