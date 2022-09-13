//
//  IconTextView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.07.22.
//

import Foundation
import SwiftUI

protocol IconTextView: View {
    var mode: IconTextMode {get}

    associatedtype IconPart: View
    associatedtype TextPart: View

    @ViewBuilder var icon: Self.IconPart {get}
    @ViewBuilder var text: Self.TextPart {get}
}

enum IconTextMode {
    case icon
    case text
    case iconAndText
    case textAndIcon
}

extension IconTextView {
    @ViewBuilder var body: some View {
        switch mode {
        case .icon:
            icon
        case .text:
           text
        case .iconAndText:
            HStack {
                icon
                text
            }
        case .textAndIcon:
            HStack {
                text
                icon
            }
        }
    }
}
