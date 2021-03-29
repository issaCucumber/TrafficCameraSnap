//
//  Common.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

import MapKit

struct Location: Decodable {
    let latitude: Double
    let longitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct ImageMetadata: Decodable {
    let height: Int
    let width: Int
    let md5: String
}

enum APIStatus {
    case healthy
    case sick
}

struct APIInfo: Decodable {
    let status: String
    
    var readableStatus: APIStatus {
        if status == "healthy" {
            return .healthy
        }
        
        return .sick
    }
}
