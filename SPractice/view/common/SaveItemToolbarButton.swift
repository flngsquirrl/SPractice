//
//  SaveItemToolbarButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 14.08.22.
//

import SwiftUI

struct SaveItemToolbarButton: View {
    
    var isExampleModified: () -> Bool
    var onSave: (_ markAsNonExample: Bool) -> Void
    
    @State private var showExampleUpdateConfirmation = false
    
    var body: some View {
        Button("Save") {
            showExampleUpdateConfirmation = isExampleModified()
            if !showExampleUpdateConfirmation {
                onSave(false)
            }
        }
        .alert("Please, note", isPresented: $showExampleUpdateConfirmation) {
            Button("Save") { onSave(true) }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This is an example template. You can later reset the changes made to it in Settings")
        }
    }
}

struct SaveItemToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveItemToolbarButton { true } onSave: { _ in }
    }
}

