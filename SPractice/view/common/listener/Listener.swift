//
//  Listener.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation
import Combine

protocol Listener {

    func listenTo(target: ObservableObjectPublisher)
    func listenTo(targets: [ObservableObjectPublisher])
}
