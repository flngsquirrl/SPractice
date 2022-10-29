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
    var infoController: InfoController {get}
}

extension InfoContentHolder {

    var body: some View {
        content.addInfoPanel(controller: infoController)
    }
}
