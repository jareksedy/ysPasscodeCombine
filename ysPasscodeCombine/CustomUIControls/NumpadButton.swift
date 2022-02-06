//
//  NumpadButton.swift
//  ysPasscodeCombine
//
//  Created by Ярослав on 06.02.2022.
//

import UIKit

class NumpadButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 2.0
        self.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 36.0, weight: .light)
        
        addTarget(self, action: #selector(tapDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(tapUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }

    @objc private func tapDown(sender: UIButton) {
        self.backgroundColor = .quaternarySystemFill
    }
    
    @objc private func tapUp(sender: UIButton) {
        UIView.animate(withDuration: 0.75, delay: 0, options: [.allowUserInteraction]) {
            self.backgroundColor = .clear
        }
    }
}
