//
//  ItemSelectionManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.07.22.
//

import Foundation
import SwiftUI

@MainActor protocol ItemSelectionManager: AnyObject {
    var newItem: UUID? {get set}
}

extension ItemSelectionManager {
    func onNewItemAdded(id: UUID) {
        withAnimation {
            newItem = id
        }
    }
}

@MainActor class ProgramSelectionManager: ObservableObject, ItemSelectionManager {
    var newItem: UUID?
    @Published var detailsItem: UUID?
    
    static let shared = ProgramSelectionManager()
}

@MainActor class ExerciseSelectionManager: ObservableObject, ItemSelectionManager {
    var newItem: UUID?
    @Published var detailsItem: UUID?
    
    static let shared = ExerciseSelectionManager()
}
