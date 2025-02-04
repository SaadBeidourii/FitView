//
//  ProgressSlider.swift
//  FitView
//
//  Created by Saad Beidouri on 04/02/2025.
//
import SwiftUI

struct ProgressSlider: View {
    let value: Double
    let color: Color
    
    private var percentage: Int {
        Int(value * 100)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background track
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 24)
                
                // Progress bar
                RoundedRectangle(cornerRadius: 6)
                    .fill(color)
                    .frame(width: geometry.size.width * CGFloat(min(max(value, 0), 1)), height: 24)
                
                // Percentage text
                Text("\(percentage)%")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading, 8)
            }
        }
        .frame(height: 24)
    }
}
