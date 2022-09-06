//
//  ContentView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.09.22.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewRouter = ViewRouter()

    var body: some View {
        switch viewRouter.currentView {
        case .home:
            HomeView()
                .transition(.opacity)
        case .onboarding:
            OnboardingView()
                .environmentObject(viewRouter)
                .transition(.opacity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
