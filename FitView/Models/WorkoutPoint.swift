//
//  WorkoutPoint.swift
//  GPXViewer
//
//  Created by Saad Beidouri on 29/12/2024.
//
import Foundation
import CoreLocation

public struct WorkoutPoint: Identifiable {
    public let id: UUID
    public let coordinate: CLLocationCoordinate2D
    public let time: Date?
    
    public init(id: UUID = UUID(), coordinate: CLLocationCoordinate2D, time: Date?) {
        self.id = id
        self.coordinate = coordinate
        self.time = time
    }
}
