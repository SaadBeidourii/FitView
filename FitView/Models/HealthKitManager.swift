//
//  HealthKitManager.swift
//  GPXViewer
//
//  Created by Saad Beidouri on 01/02/2025.
//

import HealthKit

class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()
    let healthStore = HKHealthStore()
    
    @Published var steps: Int = 0
    @Published var activeEnergy: Double = 0
    @Published var heartRate: Int = 0
    @Published var distance: Double = 0
    @Published var workouts: [HKWorkout] = []
    
    private init() {}
    
    func requestAuthorization() async throws {
        guard HKHealthStore.isHealthDataAvailable() else {
            throw HealthError.healthKitNotAvailable
        }
        
        let readTypes: Set<HKObjectType> = [
                HKObjectType.quantityType(forIdentifier: .stepCount)!,
                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKObjectType.quantityType(forIdentifier: .heartRate)!,
                HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                HKObjectType.workoutType()
            ]
        
        let shareTypes: Set<HKSampleType> = []
            
        try await healthStore.requestAuthorization(toShare: shareTypes, read: readTypes)
    }
    
    func fetchTodaySteps() async {
        let stepsType = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(
            withStart: Calendar.current.startOfDay(for: Date()),
            end: Date()
        )
        
        let query = HKStatisticsQuery(
            quantityType: stepsType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { [weak self] _, statistics, _ in
            guard let sum = statistics?.sumQuantity() else { return }
            DispatchQueue.main.async {
                self?.steps = Int(sum.doubleValue(for: .count()))
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchActiveEnergy() async {
        let energyType = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(
            withStart: Calendar.current.startOfDay(for: Date()),
            end: Date()
        )
        
        let query = HKStatisticsQuery(
            quantityType: energyType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { [weak self] _, statistics, _ in
            guard let sum = statistics?.sumQuantity() else { return }
            DispatchQueue.main.async {
                self?.activeEnergy = sum.doubleValue(for: .kilocalorie())
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchDistance() async {
        let distanceType = HKQuantityType(.distanceWalkingRunning)
        let predicate = HKQuery.predicateForSamples(
            withStart: Calendar.current.startOfDay(for: Date()),
            end: Date()
        )
        
        let query = HKStatisticsQuery(
            quantityType: distanceType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { [weak self] _, statistics, _ in
            guard let sum = statistics?.sumQuantity() else { return }
            DispatchQueue.main.async {
                self?.distance = sum.doubleValue(for: .meter()) / 1000 // Convert to kilometers
            }
        }
        
        healthStore.execute(query)
    }
    
    
    
    enum HealthError: Error {
        case healthKitNotAvailable
    }
}
