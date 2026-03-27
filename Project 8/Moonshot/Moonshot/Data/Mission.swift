//
//  Mission.swift
//  Moonshot
//
//  Created by Freak on 27.03.2026.
//
import Foundation

struct Mission: Codable, Identifiable{
    struct CrewRole: Codable{
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
