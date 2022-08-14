//
//  DeleteAlert.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import SwiftUI

struct DeleteAlertConstants {
    static let title = "Please, note"
    static let simpleWarningText = Text("It won't be possible to restore the template")
    static let exampleWarningText = Text("This template is a default example. You can later restore it from Settings")
    
    static func getWarningText(isExampleTemplate: Bool = false) -> Text {
        isExampleTemplate ? exampleWarningText : simpleWarningText 
    }
}

struct DeleteToolbarButton<T>: View where T: ExampleItem {
    var item: T
    var onDelete: (T) -> Void
    
    @State private var showDeleteConfirmation: Bool = false
    
    var body: some View {
        Button {
            showDeleteConfirmation = true
        } label: {
            Image(systemName: "trash")
        }
        .alert(DeleteAlertConstants.title, isPresented: $showDeleteConfirmation) {
            DeleteAlertContent(item: item) {
                onDelete($0)
            }
        } message: {
            DeleteAlertConstants.getWarningText(isExampleTemplate: item.isExample)
        }
    }
}

struct DeleteAlertContent<T>: View {
    var item: T
    var onDelete: (T) -> Void
    
    var body: some View {
        Button("Delete", role: .destructive) {
            withAnimation {
                onDelete(item)
            }
        }
    }
}

struct DeleteAlert_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAlertContent(item: "test", onDelete: { _ in })
    }
}
