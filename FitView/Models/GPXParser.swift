//
//  GPXParser.swift
//  GPXViewer
//
//  Created by Saad Beidouri on 29/12/2024.
//
import Foundation
import CoreLocation

class GPXParser: NSObject, XMLParserDelegate {
    private var points: [WorkoutPoint] = []
    private var currentElement = ""
    private var currentLat: Double?
    private var currentLon: Double?
    private var currentTime: Date?
    
    func parse(data: Data) -> [WorkoutPoint] {
        points = []
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return points
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if elementName == "trkpt" {
            if let lat = attributeDict["lat"], let lon = attributeDict["lon"],
               let latDouble = Double(lat), let lonDouble = Double(lon) {
                currentLat = latDouble
                currentLon = lonDouble
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElement == "time" {
            let dateFormatter = ISO8601DateFormatter()
            currentTime = dateFormatter.date(from: string.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "trkpt" {
            if let lat = currentLat, let lon = currentLon {
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                points.append(WorkoutPoint(coordinate: coordinate, time: currentTime))
            }
            currentLat = nil
            currentLon = nil
            currentTime = nil
        }
    }
}
