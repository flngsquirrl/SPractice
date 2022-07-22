//
//  RoundIconButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.07.22.
//

import SwiftUI

struct RoundIconButton: View {
    
    var imageName: String
    var disabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .fill(.lightOrange)
                    .opacity(disabled ? 0.6 : 1)
                    .frame(width: 50, height: 50)
                
                Image(systemName: imageName)
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                    .font(.largeTitle.bold())
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
        }
        .disabled(disabled)
    }
}

struct RoundIconButton_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RoundIconButton(imageName: "arrow.clockwise.circle.fill", disabled: false, action: {})
            
            RoundIconButton(imageName: ExerciseTypeImage.imageName(for: .tabata), disabled: false, action: {})
            
            RoundIconButton(imageName: ExerciseTypeImage.imageName(for: .flow), disabled: false, action: {})
            
            RoundIconButton(imageName: ExerciseTypeImage.imageName(for: .timer), disabled: false, action: {})
        }
    }
}
