//
//  Item.swift
//  ThunderRealmHero
//
//  Created by ClydeHsieh on 2025/3/6.
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
