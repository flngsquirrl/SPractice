//
//  View-RowLeadingAligned.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.09.22.
//

import SwiftUI

struct RowLeadingAligned: ViewModifier {
    func body(content: Content) -> some View {
        content
            .alignmentGuide(.listRowSeparatorLeading) { dimensions in
                dimensions[.leading]
            }
    }
}

extension View {
    func rowLeadingAligned() -> some View {
        modifier(RowLeadingAligned())
    }
}
