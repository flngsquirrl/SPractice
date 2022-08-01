//
//  ItemSelectionManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.07.22.
//

import Foundation
import SwiftUI

@MainActor protocol ItemSelectionManager: AnyObject {
    var selection: UUID? {get set}
    var newItem: UUID? {get set}
    var detailsItem: UUID? {get set}
    var isInUse: Bool {get set}
}

extension ItemSelectionManager {
    func onNewItemAdded(id: UUID, isRegularSize: Bool) {
        withAnimation {
            newItem = id
            if isRegularSize {
                selection = id
            }
        }
    }
    
    func onItemDelete(id: UUID) {
        if selection == id {
            selection = nil
        }
        
        if newItem == id {
            newItem = nil
        }
        
        if detailsItem == id {
            detailsItem = nil
        }
    }
    
    func onItemDetailsOpened(id: UUID) {
        detailsItem = id
    }
    
    func switchInUse() {
        withAnimation {
            isInUse.toggle()
            newItem = nil
            selection = nil
        }
    }
}

@MainActor class ProgramSelectionManager: ObservableObject, ItemSelectionManager {
    @Published var selection: UUID?
    var newItem: UUID?
    @Published var detailsItem: UUID?
    var isInUse: Bool = true
    
    static let shared = ProgramSelectionManager()
}

@MainActor class ExerciseSelectionManager: ObservableObject, ItemSelectionManager {
    @Published var selection: UUID?
    var newItem: UUID?
    @Published var detailsItem: UUID?
    @Published var isInUse: Bool = false
    
    static let shared = ExerciseSelectionManager()
}
