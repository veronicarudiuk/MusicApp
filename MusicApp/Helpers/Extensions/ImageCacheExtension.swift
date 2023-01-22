//
//  ImageCacheExtension.swift
//  MusicApp
//
//  Created by Марс Мазитов on 18.01.2023.
//

import UIKit

extension NSObject {
    
    func cachedImage(url: String, result: @escaping (UIImage) -> Void) {
        if let cachedImage = NSCache<NSString, UIImage>().object(forKey: url as NSString) {
            result(cachedImage)
        }
        guard let urlForRequest = URL(string: url) else { return }
        URLSession.shared.dataTask(with: urlForRequest) { data, _, _ in
            guard let data = data else { return }
            guard let seccessImage = UIImage(data: data) else { return }
            NSCache<NSString, UIImage>().setObject(seccessImage, forKey: url as NSString)
            result(seccessImage)
        } .resume()
    }
}
