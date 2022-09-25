//
//  SignalChangeListener.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation
import Combine

class SignalChangeListener: Listener, ObservableObject {

    var subscriptions: Set<AnyCancellable> = []

    func listenTo(target: ObservableObjectPublisher, action: (() -> Void)? = nil) {
        target.sink(receiveValue: { [weak self] _ in
            action?()
            self?.objectWillChange.send()
        }).store(in: &self.subscriptions)
    }

    func listenTo(targets: [ObservableObjectPublisher], action: (() -> Void)? = nil) {
        targets.forEach {
            listenTo(target: $0, action: action)
        }
    }
}
