//
//  MissionDetailsView.swift
//  Moonshot
//
//  Created by Freak on 27.03.2026.
//

import SwiftUI

struct MissionDetailsView: View {
    let mission: Mission

    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                missionImage
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.gray)
                VStack(alignment: .leading) {
                    Text(AppDefaults.crewSectionTitle)
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    CrewScrollView(crew: crew)
                    
                    separator
                    
                    Text(AppDefaults.missionHighlights)
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    var missionImage: some View{
        Image(mission.image)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { width, axis in
                width * 0.6
            }
            .padding(.top)
    }
    
    var separator: some View{
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionDetailsView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
