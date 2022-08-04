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
    
    var body: some View {
        Menu {
            ForEach(SortProperty.allCases, id: \.self) { property in
                Button() {
                    setSorting(property: property, order: getOrderToSet(property: property))
                } label: {
                    Label("\(property.rawValue)", systemImage: getOptionImage(property: property))
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
    
    func getOptionImage(property: SortProperty) -> String {
        var optionImage: String = ""
        if property == sortProperty {
            if sortOrder == .asc {
                optionImage = "arrow.down"
            } else {
                optionImage = "arrow.up"
            }
        } else {
            optionImage = "arrow.up.arrow.down"
        }
        return optionImage
    }
    
    func setSorting(property: SortProperty, order: SortOrder) {
        sortProperty = property
        sortOrder = order
    }
}

struct SortingMenu_Previews: PreviewProvider {
    static var previews: some View {
        SortingMenu(sortProperty: .constant(.date), sortOrder: .constant(.asc))
    }
}
