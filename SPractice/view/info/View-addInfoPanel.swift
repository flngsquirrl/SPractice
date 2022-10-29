//
//  View-addInfo.swift
//  SPractice
//
//  Created by Yuliya Charniak on 14.09.22.
//

import SwiftUI

extension View {
    func addInfoPanel(controller: InfoController) -> some View {
        ZStack {
            self.zIndex(0)
            InfoPanel().zIndex(1)
        }
        .environmentObject(controller)
     }
}
