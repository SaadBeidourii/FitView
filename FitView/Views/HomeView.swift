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
                        icon: "figure.walk",
                        indicator: .progress(
                            current: Double(healthManager.steps),
                            goal: 10000,
                            color: .green
                        )
                    )
                    
                    MetricCard(
                        title: "Active Energy",
                        value: String(format: "%.0f kcal", healthManager.activeEnergy),
                        icon: "flame.fill",
                        indicator: .progress(
                            current: healthManager.activeEnergy,
                            goal: 2700,
                            color: .orange
                        )
                    )
                    
                    MetricCard(
                        title: "Heart Rate",
                        value: String(format: "%.0f bpm", healthManager.heartRate),
                        icon: "heart.fill",
                        indicator: .zones(
                            currentBPM: healthManager.heartRate,
                            zones: HeartRateZone.defaultZones)
                    )
                    
                    MetricCard(
                        title: "Distance",
                        value: formattedDistance,
                        icon: "figure.walk",
                        indicator: .progress(
                            current: healthManager.distance ,
                            goal: 18.0,
                            color: .blue
                        )
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
