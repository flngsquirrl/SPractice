//
//  ViewModelListener.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation
import Combine

class ViewModelListener: ObservableObject {

    var subscriptions: Set<AnyCancellable> = []

    func listenTo(target: ObservableObjectPublisher) {
        target.sink(receiveValue: { [weak self] _ in
            self?.objectWillChange.send()
        }).store(in: &self.subscriptions)
    }

    func listenTo(targets: [ObservableObjectPublisher]) {
        targets.forEach {
            listenTo(target: $0)
        }
    }
}
