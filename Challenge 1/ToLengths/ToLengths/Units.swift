//
//  Units.swift
//  ToLengths
//
//  Created by Freak on 24.03.2026.
//

import Foundation

enum Units: CaseIterable {
    case meters, kilometers, feet, yards, miles

    var metersMultiplier: Double {
        switch self {
        case .kilometers: return 0.001
        case .feet: return 3.28084
        case .yards: return 1.09361
        case .miles: return 0.000621371
        case .meters: return 1.0
        }
    }

    var unitSuffix: String {
        switch self {
        case .kilometers: return "km"
        case .feet: return "ft"
        case .yards: return "yd"
        case .miles: return "mi"
        case .meters: return "m"
        }
    }
}
