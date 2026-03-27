//
//  ContentView.swift
//  Moonshot
//
//  Created by Freak on 27.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewType = "Grid"
    
    let viewTypes = ["Grid", "List"]
    
    var body: some View {
        NavigationStack {
            MissionListView()
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Picker("", selection: $viewType){
                            ForEach(viewTypes, id:\.self){ type in
                                Text(type)
                            }
                        }
                    }label:{
                        Text("Show as")
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
