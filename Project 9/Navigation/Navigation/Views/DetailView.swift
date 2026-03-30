//
//  DetailView.swift
//  Navigation
//
//  Created by Freak on 30.03.2026.
//
import SwiftUI

struct DetailView: View {
    var number: Int
    @Binding var path: NavigationPath

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .toolbar {
                navigateHome
            }
            .navigationTitle("Number: \(number)")
    }
    
    private var navigateHome: some ToolbarContent{
        ToolbarItem(placement: .confirmationAction){
            Button("Home") {
                path = NavigationPath()
            }
        }
    }
    
}

