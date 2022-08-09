//
//  SortingMenu.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import SwiftUI

struct SortingMenu: View {
    @Binding var sortProperty: SortProperty
    @Binding var sortOrder: SortOrder
    
    var onApplySorting: () -> Void
    
    var body: some View {
        Menu {
            ForEach(SortProperty.allCases, id: \.self) { property in
                Button() {
                    setSortProperty(property)
                    onApplySorting()
                } label: {
                    if property == sortProperty {
                        Image(systemName: "checkmark")
                    }
                    Text("\(property.rawValue)")
                }
            }
            Divider()
            ForEach(SortOrder.allCases, id: \.self) { order in
                Button() {
                    setSortOrder(order)
                    onApplySorting()
                } label: {
                    if order == sortOrder {
                        Image(systemName: "checkmark")
                    }
                    Text("\(order.rawValue)")
                }
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down")
        }
    }
    
    func getOrderToSet(property: SortProperty) -> SortOrder {
        let order: SortOrder
        if property == sortProperty {
            order = sortOrder.opposite
        } else {
            order = SortOrder.asc
        }
        return order
    }
    
    func setSortProperty(_ property: SortProperty) {
        sortProperty = property
    }
    
    func setSortOrder(_ order: SortOrder) {
        sortOrder = order
    }
}

struct SortingMenu_Previews: PreviewProvider {
    static var previews: some View {
        SortingMenu(sortProperty: .constant(.date), sortOrder: .constant(.asc)) { }
    }
}
