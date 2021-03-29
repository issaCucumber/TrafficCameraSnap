//
//  CameraMapViewModel.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

import Foundation
import Combine
import MapKit

class CameraMapViewModel: ObservableObject {
    
    @Published var annotations: [CameraMapAnnotation] = []
    @Published var selectedCamera: Camera?
    
    var cameraMap: [String: Camera] = [:]
    var cancellableSet = Set<AnyCancellable>()
    
    init() {
        
        // initialize the data set
        self.fetchData()
        
        // the app regularly update camera data every 1 min, to check if there is new camera location
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            self.fetchData()
        }
    }
    
    func selectCamera(_ cameraId: String) {
        self.fetchData(selectedCameraId: cameraId)
    }
    
    // if selectedCameraId is set, the app will set the camera object after fetching data from the source
    private func fetchData(selectedCameraId: String? = nil) {
        cancellableSet.removeAll()
        TrafficDataRDS.listAll("")
            .sink(receiveCompletion: { (error) in
                print(error)
            }, receiveValue: { [weak self] (response) in
                if response.apiInfo.readableStatus == .healthy {
                    let cameras = response.items.first?.cameras ?? []
                    self?.update(cameras, selectedCameraId: selectedCameraId)
                }
            })
            .store(in: &cancellableSet)
    }
    
    private func update(_ data: [Camera], selectedCameraId: String?) {
        data.forEach { (camera) in
            if camera != self.cameraMap[camera.cameraId] {
                // invalidate the image cache if there is any update to this camera
                ImageURLLoader.shared.invalidateCache(camera.image)
                self.cameraMap[camera.cameraId] = camera
            }
        }
        
        // update all annotations
        self.annotations = self.cameraMap.values.annotations
        
        // if the update is from the select action, assign the camera object
        if let selectedCameraId = selectedCameraId {
            self.selectedCamera = self.cameraMap[selectedCameraId]
        }
    }
}
