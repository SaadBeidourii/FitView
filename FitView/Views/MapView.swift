//
//  MapView.swift
//  GPXViewer
//
//  Created by Saad Beidouri on 29/12/2024.
//
import SwiftUI
import MapKit

struct MapView: View {
    let points: [WorkoutPoint]
    let cameraPosition: MapCameraPosition
    
    var body: some View {
        Map(position: .constant(cameraPosition)) {
            if points.count > 1 {
                MapPolyline(coordinates: points.map(\.coordinate))
                    .stroke(.blue, lineWidth: 3)
            }
            
            if let startPoint = points.first {
                Annotation("Start", coordinate: startPoint.coordinate) {
                    Image(systemName: "flag.fill")
                        .foregroundColor(.green)
                }
            }
            
            if let endPoint = points.last {
                Annotation("End", coordinate: endPoint.coordinate) {
                    Image(systemName: "flag.checkered")
                        .foregroundColor(.red)
                }
            }
        }
        .mapStyle(.standard)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
