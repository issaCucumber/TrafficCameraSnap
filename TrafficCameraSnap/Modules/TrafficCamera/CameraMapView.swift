//
//  CameraMapView.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

import SwiftUI
import MapKit

struct CameraMapView: View {
    @ObservedObject var cameraMapViewModel: CameraMapViewModel = CameraMapViewModel()
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedCameraId: String = ""
    @State private var isCameraDetailShown: Bool = false
    
    var body: some View {
        VStack {
            if cameraMapViewModel.cameraMap.isEmpty {
                Text("No Record Found")
            } else {
                MapView(centerCoordinate: $centerCoordinate, selectedCameraId: $selectedCameraId, annotations: cameraMapViewModel.annotations)
                    .edgesIgnoringSafeArea(.all)
            }  
        }
        .fullScreenCover(isPresented: $isCameraDetailShown) {
            CameraDetailView(selectedCameraId: $selectedCameraId, camera: cameraMapViewModel.selectedCamera)
        }
        .onChange(of: selectedCameraId) { (value) in
            if !value.isEmpty {
                cameraMapViewModel.selectCamera(value)
            }
        }
        .onReceive(cameraMapViewModel.$selectedCamera) { (camera) in
            isCameraDetailShown = camera != nil ? true : false
        }
    }
}

//struct CameraMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraMapView()
//    }
//}
