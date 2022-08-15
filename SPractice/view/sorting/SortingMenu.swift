//
//  SortingControl.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import SwiftUI

struct SortingControl: View {
    @Binding var sortingProperty: SortingProperty
    @Binding var sortingOrder: SortingOrder
    
    var onApplySorting: () -> Void
    
    @State private var showConfirmation = false
    
    var body: some View {
        Button {
            showConfirmation = true
        } label: {
            Image(systemName: "arrow.up.arrow.down")
                .scaleEffect(0.9)
        }
        .confirmationDialog("Apply sorting", isPresented: $showConfirmation) {
            Button("name (A-Z)") { setSorting(property: .name, order: .asc) }
            Button("name (Z-A)") { setSorting(property: .name, order: .desc) }
            Button("creation time (oldest first)") { setSorting(property: .date, order: .asc) }
            Button("creation time (newest first)") { setSorting(property: .date, order: .desc) }
        } message: {
            Text("Sort by")
        }
    }
    
    func setSorting(property: SortingProperty, order: SortingOrder) {
        setSortingProperty(property)
        setSortingOrder(order)
        
        onApplySorting()
    }
    
    func setSortingProperty(_ property: SortingProperty) {
        sortingProperty = property
    }
    
    func setSortingOrder(_ order: SortingOrder) {
        sortingOrder = order
    }
}

struct SortingControl_Previews: PreviewProvider {
    static var previews: some View {
        SortingControl(sortingProperty: .constant(.date), sortingOrder: .constant(.asc)) { }
    }
}

