//
//  ContentView.swift
//  Moonshot
//
//  Created by Freak on 27.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewType = AppDefaults.defaultViewType
    @State private var viewOpacity = AppDefaults.defaultOpacity

    let viewTypes = AppDefaults.viewTypes

    var body: some View {
        NavigationStack {
            Group {
                if viewType == "Grid" {
                    MissionGridView()
                } else {
                    MissionListView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("", selection: $viewType) {
                            ForEach(viewTypes, id: \.self) { type in
                                Text(type)
                            }
                        }
                    } label: {
                        Text(AppDefaults.toolbarMenuLabel)
                    }
                }
            }
            .navigationTitle(AppDefaults.navigationTitle)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
    
    
}

#Preview {
    ContentView()
}
