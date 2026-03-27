//
//  MissionCardView.swift
//  Moonshot
//
//  Created by Freak on 27.03.2026.
//

import SwiftUI

struct MissionCardView: View {
    let mission: Mission
    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius:10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
}

#Preview {
    MissionCardView(mission: Mission(id: 1, launchDate: Date.now, crew: [Mission.CrewRole(name:"grissom", role:"")], description: "Lorem"))
}
