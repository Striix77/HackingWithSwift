//
//  Order.swift
//  CupcakeCorner
//
//  Created by Freak on 31.03.2026.
//
import Foundation

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false
    var extraFrosting = false
    var addSprinkles = false
}
