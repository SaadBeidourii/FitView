//
//  MetricCard.swift
//  GPXViewer
//
//  Created by Saad Beidouri on 01/02/2025.
//

import SwiftUI

struct MetricCard: View {
    let title: String
    let value: String
    let icon: String
    let indicator: MetricIndicator?
    
    var body: some View {
        VStack(alignment: .leading) {

            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    if let indicator = indicator {
                            indicator.view()
                    }
                }
            }
            // Value section
            Text(value)
                .font(.system(size: 38, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .padding(24)
        .frame(maxWidth: .infinity, idealHeight: 180)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}

