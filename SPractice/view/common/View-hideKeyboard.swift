//
//  View-hideKeyboard.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.08.22.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
