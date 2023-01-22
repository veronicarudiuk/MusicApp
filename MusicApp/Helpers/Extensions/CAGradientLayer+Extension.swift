//
//  CAGradientLayer+Extension.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 18/01/2023.
//

import UIKit

//extension CAGradientLayer {
////    convenience init (view: UIView) {
////        self.init()
////        self.frame = view.frame
////        let startColor = UIColor(named: K.BrandColors.blueColor)?.cgColor
////        let endColor = UIColor(named: K.BrandColors.greenGradientColor)?.cgColor
////        guard let startColor = startColor, let endColor = endColor else {return}
////        self.colors = [startColor, endColor]
////        view.layer.insertSublayer(self, at: 0)
////    }
//    
//    func getGradientLayer(bounds: CGRect) -> UIColor? {
//    let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//    //order of gradient colors
//        let startColor = UIColor(named: K.BrandColors.blueColor)?.cgColor
//        let endColor = UIColor(named: K.BrandColors.greenGradientColor)?.cgColor
//        guard let startColor = startColor, let endColor = endColor else {return nil}
//        gradientLayer.colors = [startColor, endColor]
//    // start and end points
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//        
//    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
//      //create UIImage by rendering gradient layer.
//    gradientLayer.render(in: UIGraphicsGetCurrentContext())
//    let image = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//      //get gradient UIcolor from gradient UIImage
//    return UIColor(patternImage: image!)
//    }
//}

