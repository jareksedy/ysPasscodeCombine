//
//  UIControlSubscription.swift
//  ysPasscodeCombine
//
//  Created by Ярослав on 06.02.2022.
//

import UIKit
import Combine

final class UIControlSubscription<SubscriberType: Subscriber,
                                  Control: UIControl>: Subscription
                                  where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control

    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    func request(_ demand: Subscribers.Demand) {}

    func cancel() {
        subscriber = nil
    }

    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
}
