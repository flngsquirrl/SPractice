//
//  DeleteAlert.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import SwiftUI

struct DeleteAlertConstants {
    static let simpleWarning = "It won't be possible to restore the template."
    static let exampleWarning = "You can later restore this example template from Settings."

    static func getTitle(isExampleTemplate: Bool = false) -> String {
        isExampleTemplate ? exampleWarning : simpleWarning
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
        .alert(DeleteAlertConstants.getTitle(isExampleTemplate: item.isExample), isPresented: $showDeleteConfirmation) {
            DeleteAlertContent(item: item) {
                onDelete($0)
            }
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
