//
//  View-If.swift
//  SPractice
//
//  Created by Yuliya Charniak on 15.08.22.
//

import SwiftUI

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
         if conditional {
             return AnyView(content(self))
         } else {
             return AnyView(self)
         }
     }
}
