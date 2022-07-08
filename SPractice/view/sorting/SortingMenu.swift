//
//  SortingMenu.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import SwiftUI

struct SortingMenu: View {
    var onChange: (SortProperty, SortOrder) -> Void
    var isSet: (SortProperty, SortOrder) -> Bool
    
    var body: some View {
        Menu {
            ForEach(SortProperty.allCases, id: \.self) { property in
                ForEach(SortOrder.allCases, id: \.self) { order in
                    Button() {
                        onChange(property, order)
                    } label: {
                        let optionName = "\(property.rawValue) (\(order.rawValue))"
                        if isSet(property, order) {
                            Label(optionName, systemImage: "checkmark")
                        } else {
                            Text(optionName)
                        }
                    }
                }
            }
        } label: {
            Label("Sort by", systemImage: "arrow.up.arrow.down")
        }
    }
}

struct SortingMenu_Previews: PreviewProvider {
    static var previews: some View {
        SortingMenu(onChange: {_, _ in }, isSet: {_, _ in return false})
    }
}
