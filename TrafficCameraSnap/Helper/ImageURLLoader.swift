//
//  ImageLoader.swift
//  TrafficCameraSnap
//
//  Created by Christina Lui on 28/3/21.
//

import Foundation
import Combine
import UIKit

class ImageURLLoader: ObservableObject {
    
    @Published var image: UIImage? {
        didSet {
            isImageLoaded = false
            if self.image != nil {
                isImageLoaded = true
            }
        }
    }
    @Published var isImageLoaded: Bool = false
    
    var cancellableSet = Set<AnyCancellable>()
    private let cache = NSCache<NSString, UIImage>()
    static let shared = ImageURLLoader()
    
    func loadImage(_ urlString: String) {
        isImageLoaded = false
        cancellableSet.removeAll()
        
        if let image = cache.object(forKey: urlString as NSString) {
            self.image = image
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTaskPublisher(for: url)
                    .receive(on: DispatchQueue.main)
                    .tryMap() { element -> Data in
                        guard let httpResponse = element.response as? HTTPURLResponse,
                            httpResponse.statusCode == 200 else {
                                throw URLError(.badServerResponse)
                            }
                        return element.data
                    }
                    .sink(receiveCompletion: {
                        print ("Received completion: \($0).")
                    }, receiveValue: { [weak self] in
                        let image = UIImage(data: $0)
                        
                        // cache the image
                        self?.cache.removeObject(forKey: urlString as NSString)
                        self?.cache.setObject(image!, forKey: urlString as NSString)
                        self?.image = image
                    })
                    .store(in: &cancellableSet)
        }
    }
    
    func invalidateCache(_ urlString: String) {
        self.cache.removeObject(forKey: urlString as NSString)
    }
}
