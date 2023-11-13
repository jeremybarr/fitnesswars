//
//  Item.swift
//  FitnessWars
//
//  Created by Jeremy Barr on 10/29/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
