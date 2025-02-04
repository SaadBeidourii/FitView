//
//  HeartRateZonesView.swift
//  FitView
//
//  Created by Saad Beidouri on 04/02/2025.
//

import SwiftUI

struct HeartRateZonesView: View {
    let currentBPM: Int
    let currentZone: HeartRateZone
    
    var body: some View {
        HStack {
            Text("ZONE \(currentZone.zoneNumber)")
                .font(.caption2)
                .bold()
                .foregroundColor(.white)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(currentZone.color)
        )
    }
}
