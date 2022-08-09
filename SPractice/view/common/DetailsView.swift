//
//  DetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.07.22.
//

import Foundation
import SwiftUI

protocol DetailsView: View {
    var isDeleted: Bool {get}
    var sizeClass: UserInterfaceSizeClass? {get}
    
    associatedtype Content: View
    var detailsContent: Content {get}
}

extension DetailsView {
    @ViewBuilder var body: some View {
        Group {
            if sizeClass == .regular {
                if isDeleted {
                    WelcomeView()
                } else {
                    detailsContent
                }
            } else {
                detailsContent
            }
        }
    }
}
