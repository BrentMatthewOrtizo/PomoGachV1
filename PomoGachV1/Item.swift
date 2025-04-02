//
//  Item.swift
//  PomoGachV1
//
//  Created by Brent Matthew Ortizo on 4/2/25.
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
