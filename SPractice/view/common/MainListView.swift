//
//  MainListView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.08.22.
//

import SwiftUI

@MainActor protocol MainListView: ManagedList {
    associatedtype ListSelectionManager: ItemSelectionManager
    associatedtype ListDataManager: DataManager
    
    var selectionManager: ListSelectionManager {get}
    var dataManager: ListDataManager {get}
    
    var sizeClass: UserInterfaceSizeClass? {get}
}

extension MainListView {
    
    var secondaryView: some View {
        WelcomeView()
    }
    
    func addItem(_ item: ListDataManager.Item) {
        dataManager.addNew(item)
        selectionManager.onNewItemAdded(id: item.id, isRegularSize: isRegularSize)
    }
    
    func deleteItem(_ item: ListDataManager.Item) {
        dataManager.delete(item)
        selectionManager.onItemDelete(id: item.id)
    }

    var elements: [ListDataManager.Item] {
        dataManager.items
    }
    
    var isRegularSize: Bool {
        sizeClass == .regular
    }
}
