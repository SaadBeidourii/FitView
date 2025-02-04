//
//  MetricIndicator.swift
//  FitView
//
//  Created by Saad Beidouri on 04/02/2025.
//

import SwiftUI

enum MetricIndicator {
    case goal(String)
    case zones(currentBPM: Int, zones: [HeartRateZone])
    case progress(current: Double, goal: Double, color: Color = .blue)
    case custom(String)
}
