//
//  HideKeyboardButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.08.22.
//

import SwiftUI

struct HideKeyboardButton: View {
    var body: some View {
        Button("Done") {
            hideKeyboard()
        }
    }
}

struct HideKeyboardButton_Previews: PreviewProvider {
    static var previews: some View {
        HideKeyboardButton()
    }
}
