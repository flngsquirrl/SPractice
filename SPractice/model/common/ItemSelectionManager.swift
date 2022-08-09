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
    var detailsItem: UUID? {get set}
}

extension ItemSelectionManager {
    func onNewItemAdded(id: UUID) {
        withAnimation {
            newItem = id
        }
    }
    
    func onItemDelete(id: UUID) {
        if detailsItem == id {
            detailsItem = nil
        }
    }
    
    func onItemDetailsOpened(id: UUID) {
        detailsItem = id
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
