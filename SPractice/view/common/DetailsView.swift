//
//  DetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.07.22.
//

import Foundation
import SwiftUI

protocol DetailsView: View {
    var isClosed: Bool {get}
    var sizeClass: UserInterfaceSizeClass? {get}
    
    associatedtype Content: View
    var detailsContent: Content {get}
    
    func onAppear()
}

extension DetailsView {
    @ViewBuilder var body: some View {
        Group {
            if sizeClass == .regular {
                if isClosed {
                    WelcomeView()
                } else {
                    detailsContent
                }
            } else {
                detailsContent
            }
        }
        .onAppear() {
            onAppear()
        }
    }
}
