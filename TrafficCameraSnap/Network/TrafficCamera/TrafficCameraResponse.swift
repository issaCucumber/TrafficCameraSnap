//
//  TrafficCameraResponse.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

struct TrafficCameraResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case apiInfo = "api_info"
        case items
    }
    
    let items: [TrafficCameraItem]
    let apiInfo: APIInfo
    
}

struct TrafficCameraItem: Decodable {
    let timestamp: String
    let cameras: [Camera]
}
