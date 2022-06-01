//
//  PracticeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Combine
import SwiftUI

struct PracticeView: View {
    
    @ObservedObject var practice: Practice
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .lightNavy, location: 0.3),
                .init(color: .creamy, location: 1),
            ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                ExerciseView(practice: practice)
                //PracticeSequenceView()
                Spacer()
                PlayerView(player: practice.player)
                Spacer()
            }
        }
        .onDisappear(perform: practice.cancel)
        .navigationTitle(practice.program.name)
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(.creamy)
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PracticeView(practice: Practice(for: Program.personal))
        }
    }
}
