//
//  PasscodeViewController.swift
//  ysPasscodeCombine
//
//  Created by Ярослав on 06.02.2022.
//

import UIKit
import Combine

class PasscodeViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    private var passcode = CurrentValueSubject<String, Never>("")
    
    // Correct passcode & passcode length
    private let validPasscode = "0896"
    private let passcodeLength = 4
    
    // Outlets
    @IBOutlet weak var passcodeLabel: UILabel!
    @IBOutlet weak var passcodeStackView: UIStackView!
    @IBOutlet weak var numpadStackView: UIStackView!
    @IBOutlet var circles: [UIImageView]!
    @IBOutlet var digitButtons: [NumpadButton]!
    @IBOutlet weak var backspaceButton: NumpadButton!
    
    // View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubscriptions()
    }
    
    // Private methods
    private func setupSubscriptions() {
        digitButtons.forEach { button in
            button
                .publisher(for: .touchUpInside)
                .sink { button in
                    switch button.tag {
                    case -1:
                        guard self.passcode.value.count > 0 else { break }
                        self.passcode.value.removeLast()
                    default:
                        let value = self.passcode.value + String(button.tag)
                        self.passcode.send(value)
                    }
                }
                .store(in: &cancellables)
        }
        
        passcode
            .sink { value in
                self.validatePasscode(value)
                self.activateBackspaceButton(value.count > 0)
                self.fillCircles(value.count)
            }
            .store(in: &cancellables)
    }
    
    private func validatePasscode(_ input: String) {
        guard input.count == passcodeLength else { return }
        if input == validPasscode {
            performSegue(withIdentifier: "toMainScene", sender: nil)
        } else {
            numpadStackView.shake() {
                self.passcode.send("")
            }
        }
    }
    
    private func fillCircles(_ count: Int) {
        for (index, imageView) in circles.enumerated() {
            imageView.image = count > index ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        }
    }
    
    private func activateBackspaceButton(_ buttonActive: Bool) {
        backspaceButton.isEnabled = buttonActive
        backspaceButton.alpha = buttonActive ? 1.0 : 0.5
    }
}
