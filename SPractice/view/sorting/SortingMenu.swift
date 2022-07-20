//
//  SortingMenu.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import SwiftUI

struct SortingMenu: View {
    var sortProperty: SortProperty
    var sortOrder: SortOrder
    var onChange: (SortProperty, SortOrder) -> Void
    
    var body: some View {
        Menu {
            ForEach(SortProperty.allCases, id: \.self) { property in
                Button() {
                    onChange(property, getOrderToSet(property: property))
                } label: {
                    Label("\(property.rawValue)", systemImage: getOptionImage(property: property))
                }
            }
        } label: {
            Text("Sort by")
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
}

struct SortingMenu_Previews: PreviewProvider {
    static var previews: some View {
        SortingMenu(sortProperty: .date, sortOrder: .asc, onChange: { _,_ in })
    }
}
