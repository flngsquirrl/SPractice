//
//  DeleteAlert.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import SwiftUI

struct DeleteAlertConstants {
    static let title = "Please, note"
    static let messageText = Text("It won't be possible to restore the template")
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
