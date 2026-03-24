//
//  ContentView.swift
//  ToLengths
//
//  Created by Freak on 16.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State var inputLength = 0.0
    @State var inputUnitOfConversion: Units = Units.meters
    @State var outputUnitOfConversion: Units = Units.kilometers

    var body: some View {
        NavigationStack {
            Form {
                UnitSelectionView(
                    inputUnitOfConversion: $inputUnitOfConversion,
                    outputUnitOfConversion: $outputUnitOfConversion
                )

                ConversionInputView(
                    inputLength: $inputLength,
                    inputUnitOfConversion: $inputUnitOfConversion,
                    outputUnitOfConversion: $outputUnitOfConversion
                )

            }
            .navigationTitle("ToLengths")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UnitSelectionView: View {
    @Binding var inputUnitOfConversion: Units
    @Binding var outputUnitOfConversion: Units
    var body: some View {
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
        }
    }
}

struct ConversionInputView: View {
    @Binding var inputLength: Double
    @Binding var inputUnitOfConversion: Units
    @Binding var outputUnitOfConversion: Units

    var outputLength: Double {

        let meters = inputLength / inputUnitOfConversion.metersMultiplier

        return meters * outputUnitOfConversion.metersMultiplier
    }

    var body: some View {
        Section("Enter the value to be converted") {
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
}

#Preview {
    ContentView()
}
