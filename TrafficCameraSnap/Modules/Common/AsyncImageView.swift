//
//  AsyncImageView.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

import SwiftUI

struct AsyncImageView: View {
    
    @ObservedObject var imageLoader = ImageURLLoader.shared
    var url: String
    
    var body: some View {
        ZStack {
            if imageLoader.isImageLoaded {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            } else {
                Text("loading")
            }
        }
        .onAppear {
            imageLoader.loadImage(url)
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: "")
    }
}
