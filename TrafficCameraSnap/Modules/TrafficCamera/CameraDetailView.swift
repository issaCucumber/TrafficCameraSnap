//
//  CameraDetailView.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

import SwiftUI

struct CameraDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCameraId: String
    
    var camera: Camera?
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0, content: {
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .frame(alignment: .trailing)
            
            AsyncImageView(url: camera!.image)
        })
        .onDisappear {
            selectedCameraId = ""
        }
        
    }
}
