//
//  ImageCache.swift
//  MusicApp
//
//  Created by Марс Мазитов on 17.01.2023.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    var cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func put(image: UIImage, with url: String) {
        cache.setObject(image, forKey: url as NSString)
    }
    
    func take(with url: String) -> UIImage? {
        return cache.object(forKey: url as NSString)
    }
}
