//
//  OnboardingView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.09.22.
//

import SwiftUI

enum IntroTab {
    case exercises
    case programs
    case app
}

struct OnboardingView: View {

    @EnvironmentObject var viewRouter: ViewRouter
    @State private var selectedTab = IntroTab.exercises
    @State private var isIntoEnded = false

    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    TabView(selection: $selectedTab) {
                        IntroExercisesView()
                            .tag(IntroTab.exercises)

                        IntroProgramsView()
                            .tag(IntroTab.programs)

                        IntroAppView()
                            .tag(IntroTab.app)
                    }
                    .foregroundColor(.mainColor)
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .onChange(of: selectedTab) { _ in
                        if selectedTab == .app {
                            withAnimation {
                                isIntoEnded = true
                            }
                        }
                    }

                    VStack {
                        Spacer()
                        HStack {
                            if !isIntoEnded {
                                Button("Skip") {
                                    close()
                                }
                                .transition(.opacity)
                            }
                            Spacer()
                            if isIntoEnded {
                                Button {
                                    close()
                                } label: {
                                    Text("Start")
                                        .fontWeight(.semibold)
                                }
                                .transition(.opacity)
                            }
                        }
                        .padding()
                        .buttonStyle(.plain)
                    }
                    .foregroundColor(.customAccentColor)
                }
            }
            .frame(width: LayoutUtils.centralFrameWidth(parentContainerSize: geo.size),
                   height: min(geo.size.height * 0.8, 650))
            .wrapped()
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }

    func close() {
        withAnimation {
            viewRouter.onboard()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
