//
//  TaskTypeImage.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.06.22.
//

import SwiftUI

struct TaskTypeImage: View {
    var type: Task.TaskType
    var isFilled = false

    var body: some View {
        Image(systemName: Self.imageName(for: type, isFilled: isFilled))
    }
    
    static func imageName(for type: Task.TaskType, isFilled: Bool = false) -> String {
        let postfix = isFilled ? ".fill" : ""
        
        switch type {
        case .activity:
            return "sun.max.circle\(postfix)"
        case .rest:
            return "moon.circle\(postfix)"
        }
        
    }
}

struct TaskTypeImage_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TaskTypeImage(type: .activity)
            TaskTypeImage(type: .rest)
            
            TaskTypeImage(type: .activity, isFilled: true)
            TaskTypeImage(type: .rest, isFilled: true)
        }
    }
}
