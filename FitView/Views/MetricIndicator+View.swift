//
//  MetricIndicator+View.swift
//  FitView
//
//  Created by Saad Beidouri on 04/02/2025.
//
import SwiftUI


extension MetricIndicator {
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .goal(let value):
            Text("Goal: \(value)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
        case .zones(let currentBPM, _):
            if let currentZone = HeartRateZone.getCurrentZone(for: currentBPM) {
                HeartRateZonesView(currentBPM: currentBPM, currentZone: currentZone)
            }
            
        case .progress(let current, let goal, let color):
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Goal: \(String(format: "%.0f", goal))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                ProgressSlider(value: current/goal, color: color)
            }
            
        case .custom(let value):
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
