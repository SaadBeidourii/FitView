//
//  HomeView.swift
//  GPXViewer
//
//  Created by Saad Beidouri on 01/02/2025.
//

import SwiftUI
import HealthKit

struct HomeView: View {
    @StateObject private var healthManager = HealthKitManager.shared
    @State private var showingError = false
    @State private var errorMessage = ""
    
    private var formattedDistance: String {
            if healthManager.distance < 1.0 {
                // Convert to meters and format
                let meters = healthManager.distance * 1000
                return String(format: "%.0f m", meters)
            } else {
                // Keep kilometers format
                return String(format: "%.2f km", healthManager.distance)
            }
        }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    MetricCard(
                        title: "Steps",
                        value: "\(healthManager.steps)",
                        icon: "figure.walk"
                    )
                    
                    MetricCard(
                        title: "Active Energy",
                        value: String(format: "%.1f kcal", healthManager.activeEnergy),
                        icon: "flame.fill"
                    )
                    
                    MetricCard(
                        title: "Heart Rate",
                        value: String(format: "%.0f bpm", healthManager.heartRate),
                        icon: "heart.fill"
                    )
                    
                    MetricCard(
                        title: "Distance",
                        value: formattedDistance,
                        icon: "figure.walk"
                    )
                }
                .padding()
                
            }
            .navigationTitle("Health Metrics")
            .task {
                do {
                    try await healthManager.requestAuthorization()
                    await healthManager.fetchTodaySteps()
                    await healthManager.fetchDistance()
                    await healthManager.fetchActiveEnergy()
                } catch {
                    errorMessage = error.localizedDescription
                    showingError = true
                }
            }
            .alert("Error", isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
}
