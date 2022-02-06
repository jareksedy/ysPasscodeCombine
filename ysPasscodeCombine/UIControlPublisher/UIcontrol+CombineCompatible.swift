//
//  UIcontrol+CombineCompatible.swift
//  ysPasscodeCombine
//
//  Created by Ярослав on 06.02.2022.
//

import UIKit
import Combine

protocol CombineCompatible {}
extension UIControl: CombineCompatible {}
extension CombineCompatible where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
        return UIControlPublisher(control: self, events: events)
    }
}
