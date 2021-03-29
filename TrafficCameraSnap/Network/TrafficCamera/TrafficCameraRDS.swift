//
//  TrafficCameraRDS.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

import Foundation
import Combine

class TrafficDataRDS {
    static func listAll(_ dateTime: String?) -> AnyPublisher<TrafficCameraResponse, Error> {
        guard let host = URL(string:GOVSGAPIClient.APIHost.govsg!),
              var components = URLComponents(url: host .appendingPathComponent(GOVSGAPIClient.APIPath.getTafficCameraData.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }

        if let dateTime = dateTime, !dateTime.isEmpty {
            components.queryItems = [URLQueryItem(name: "date_time", value: dateTime)]
        }

        let request = URLRequest(url: components.url!)

        return GOVSGAPIClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
