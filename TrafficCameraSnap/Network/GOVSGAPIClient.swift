//
//  APIClient.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

import Foundation

class GOVSGAPIClient: BaseAPIClient {
    
    enum APIPath: String {
        case getTafficCameraData = "transport/traffic-images"
    }

    enum APIHost {
        static var govsg: String? {
            return Bundle.main.object(forInfoDictionaryKey: "API_HOST") as? String
        }
    }
    
}
