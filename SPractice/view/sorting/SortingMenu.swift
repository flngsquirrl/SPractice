//
//  SortingMenu.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import SwiftUI

struct SortingMenu: View {
    @Binding var sortingProperty: SortingProperty
    @Binding var sortingOrder: SortingOrder
    
    var onApplySorting: () -> Void
    
    var body: some View {
        Menu {
            ForEach(SortingProperty.allCases, id: \.self) { property in
                Button() {
                    setSortingProperty(property)
                    onApplySorting()
                } label: {
                    if property == sortingProperty {
                        Image(systemName: "checkmark")
                    }
                    Text("\(property.rawValue)")
                }
            }
            Divider()
            ForEach(SortingOrder.allCases, id: \.self) { order in
                Button() {
                    setSortingOrder(order)
                    onApplySorting()
                } label: {
                    if order == sortingOrder {
                        Image(systemName: "checkmark")
                    }
                    Text("\(order.rawValue)")
                }
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down")
        }
    }
    
    func getOrderToSet(property: SortingProperty) -> SortingOrder {
        let order: SortingOrder
        if property == sortingProperty {
            order = sortingOrder.opposite
        } else {
            order = SortingOrder.asc
        }
        return order
    }
    
    func setSortingProperty(_ property: SortingProperty) {
        sortingProperty = property
    }
    
    func setSortingOrder(_ order: SortingOrder) {
        sortingOrder = order
    }
}

struct SortingMenu_Previews: PreviewProvider {
    static var previews: some View {
        SortingMenu(sortingProperty: .constant(.date), sortingOrder: .constant(.asc)) { }
    }
}

