//
//  InfoContentContainer.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.10.22.
//

import Foundation
import SwiftUI

protocol InfoContentHolder: View {

    associatedtype Content: View

    var content: Content {get}
}

extension InfoContentHolder {

    var body: some View {
        content.addInfoPanel()
    }
}
