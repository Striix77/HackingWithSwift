//
//  MissionsView.swift
//  Moonshot
//
//  Created by Freak on 27.03.2026.
//

import SwiftUI

struct MissionGridView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        MissionCardView(mission: mission)
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationDestination(for: Mission.self) { mission in
                MissionDetailsView(mission: mission, astronauts: astronauts)
            }
        }

    }
}

#Preview {
    MissionListView()
}
