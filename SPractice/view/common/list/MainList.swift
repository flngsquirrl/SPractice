//
//  MainList.swift
//  SPractice
//
//  Created by Yuliya Charniak on 19.10.22.
//

import Foundation
import SwiftUI

struct MainList<T: ListComponentsProvider, C: MainController>: View where C.Item == T.Item {

    @ObservedObject var controller: C
    @State var componentsProvider: T

    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: C.Item?

    @State private var showAddNewView = false

    var body: some View {
        NavigationSplitView {
            list
                .navigationTitle(componentsProvider.title)
                .sheet(isPresented: $showAddNewView) {
                    addItemContent
                }
                .toolbar {
                    listToolbar
                }
        } detail: {
            detail
        }
        .navigationSplitViewStyle(.balanced)
        .accentColor(.customAccentColor)
    }

    var list: some View {
        ScrollViewReader { proxy in
            List(controller.filteredItems, selection: $controller.selected) { item in
                NavigationLink(value: item) {
                    let isAccented = item.id == selectedToDelete?.id
                    componentsProvider.getShortView(item: item, isAccented: isAccented)
                }
                .rowLeadingAligned()
                .swipeActions(edge: .trailing) {
                    SwipeDeleteButton {
                        selectedToDelete = item
                        showDeleteConfirmation = true

                    }
                }
            }
            .listStyle(.insetGrouped)
            .searchable(text: $controller.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .disableAutocorrection(true)
            .onChange(of: controller.newItem) { newItem in
                if let newItem {
                    withAnimation {
                        proxy.scrollTo(newItem, anchor: .center)
                    }
                }
            }
            .onChange(of: showDeleteConfirmation) { isShown in
                if !isShown {
                    withAnimation {
                        selectedToDelete = nil
                    }
                }
            }
            .alert(deleteAlertTitle, isPresented: $showDeleteConfirmation, presenting: selectedToDelete) { item in
                DeleteAlertContent(item: item) {
                    controller.deleteItem($0)
                }
            }
        }
    }

    var deleteAlertTitle: String {
        DeleteAlertConstants.getTitle(isExampleTemplate: selectedToDelete?.isExample ?? false)
    }

    var addItemContent: some View {
        var addItemView = componentsProvider.addItemView
        addItemView.onAdd = {
            controller.addItem($0)
        }
        return addItemView
    }

    @ViewBuilder var detail: some View {
        if let selected = controller.selected {
            getDetailsViewContent(item: selected)
        } else {
            StabView()
        }
    }

    func getDetailsViewContent(item: C.Item) -> some View {
        var detailsView = componentsProvider.getDetailsView(item: item)
        detailsView.onUpdate = { controller.updateItem($0) }
        detailsView.onDelete = { controller.deleteItem($0) }
        return detailsView
    }

    var listToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            SortingControl(sortingProperty: $controller.sortingProperty, sortingOrder: $controller.sortingOrder) {
                controller.setSorting()
            }

            Button {
                showAddNewView = true
            } label: {
                Image(systemName: "plus")
                    .frame(width: 25)
            }
        }
    }

}
