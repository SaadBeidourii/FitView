//
//  HeartRateZone.swift
//  FitView
//
//  Created by Saad Beidouri on 04/02/2025.
//

import SwiftUI

struct HeartRateZone {
    let min: Int
    let max: Int
    let color: Color
    let zoneNumber: Int
    
    static let defaultZones: [HeartRateZone] = [
        HeartRateZone(min: 0, max: 100, color: .blue, zoneNumber: 1),
        HeartRateZone(min: 101, max: 120, color: .green, zoneNumber: 2),
        HeartRateZone(min: 121, max: 140, color: .yellow, zoneNumber: 3),
        HeartRateZone(min: 141, max: 160, color: .orange, zoneNumber: 4),
        HeartRateZone(min: 161, max: 180, color: .red, zoneNumber: 5)
    ]
    
    static func getCurrentZone(for bpm: Int) -> HeartRateZone? {
        defaultZones.first { zone in
            bpm >= zone.min && bpm <= zone.max
        }
    }
}
