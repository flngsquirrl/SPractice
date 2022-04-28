//
//  ContentView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                    .init(color: .orange, location: 0.3),
                    .init(color: .black, location: 1),
                ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                ClockView.simpleCountup
                ClockView.simpleCountdown
                ClockView(setTo: 5, isCountdown: true, callback: callbackExample)
                ClockView(setTo: 55, isCountdown: false)
            }
        }
    }
    
    func callbackExample() {
        print("triggered")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
