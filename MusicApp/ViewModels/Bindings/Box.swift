//
//  Box.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 20/01/2023.
//

import Foundation

final class Box<T> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
