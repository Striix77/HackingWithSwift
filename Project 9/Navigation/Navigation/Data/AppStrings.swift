//
//  AppStrings.swift
//  Navigation
//
//  Created by Freak on 30.03.2026.
//
import Foundation

struct AppStrings{
    static let navigationLinkRandomNumber = "Go to Random Number"
    static let detailViewHomeButton = "Home"
    
    static func selectText(number: Int) -> String {
        "Select \(number)"
    }
    static func detailViewTitle(number: Int) -> String {
        "Number: \(number)"
    }
    static func stringListText(number: Int, selection: String) -> String {
        "\(number). You selected \(selection). That's a string btw."
    }
}
