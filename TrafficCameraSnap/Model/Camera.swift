//
//  Camera.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

import Foundation
import MapKit

struct Camera: Decodable, Identifiable, Equatable {
    static func == (lhs: Camera, rhs: Camera) -> Bool {
        return lhs.cameraId == rhs.cameraId && lhs.timestamp == rhs.timestamp && lhs.image == rhs.image
    }
    
    var id: String {
        cameraId
    }
    
    enum CodingKeys: String, CodingKey {
        case cameraId = "camera_id"
        case timestamp
        case image
        case location
        case imageMetadata = "image_metadata"
    }
    
    let cameraId: String
    let timestamp: String
    let image: String
    let location: Location
    let imageMetadata: ImageMetadata
}

extension Sequence where Element == Camera {
    var annotations: [CameraMapAnnotation] {
        map { (item) in
            let newLocation = CameraMapAnnotation()
            newLocation.coordinate = item.location.coordinates
            newLocation.dataIdentifer = item.cameraId
            return newLocation
        }
    }
}
