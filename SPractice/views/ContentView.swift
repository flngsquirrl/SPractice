//
//  ContentView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ProgramsView()
        }
        .accentColor(.lightNavy)
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
