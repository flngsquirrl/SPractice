//
//  EditableView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.06.22.
//

import Foundation
import SwiftUI

protocol EditableView {
    var editMode: Binding<EditMode>? {get}
}

extension EditableView {
    var isInEditMode: Bool {
        editMode?.wrappedValue.isEditing == true
    }
}
