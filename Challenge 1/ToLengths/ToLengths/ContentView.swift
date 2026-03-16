//
//  ContentView.swift
//  ToLengths
//
//  Created by Freak on 16.03.2026.
//

import SwiftUI

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

struct ContentView: View {
    @State var inputLength = 0.0
    @State var inputUnitOfConversion: Units = Units.meters
    @State var outputUnitOfConversion: Units = Units.kilometers

    var outputLength: Double {

        let meters = inputLength / inputUnitOfConversion.metersMultiplier

        return meters * outputUnitOfConversion.metersMultiplier
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Choose your units of measure") {

                    Picker("Convert from", selection: $inputUnitOfConversion) {
                        ForEach(Units.allCases, id: \.self) { unit in
                            Text(String(describing: unit).capitalized)
                        }
                    }

                    Picker("Convert to", selection: $outputUnitOfConversion) {
                        ForEach(Units.allCases, id: \.self) { unit in
                            Text(String(describing: unit).capitalized)
                        }
                    }

                    HStack {
                        TextField("", value: $inputLength, format: .number)
                            .fixedSize()
                            .keyboardType(.numbersAndPunctuation)
                        Text(inputUnitOfConversion.unitSuffix)
                            .offset(x: -5)
                        Spacer()
                        Text(
                            outputLength,
                            format: .number.precision(.fractionLength(0...4))
                        )
                        Text(outputUnitOfConversion.unitSuffix)
                            .offset(x: -5)

                    }

                }
            }
            .navigationTitle("ToLengths")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
