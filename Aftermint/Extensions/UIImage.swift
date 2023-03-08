//
//  UIImage.swift
//  Aftermint
//
//  Created by HappyDuck on 2023/01/22.
//

import UIKit

extension UIImage {
    func aspectFitImage(inRect rect: CGRect) -> UIImage? {
        let width = self.size.width
        let height = self.size.height
        let aspectWidth = rect.width / width
        let aspectHeight = rect.height / height
        let scaleFactor = aspectWidth > aspectHeight ? rect.size.height / height : rect.size.width / width

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width * scaleFactor, height: height * scaleFactor), false, 0.0)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: width * scaleFactor, height: height * scaleFactor))

        defer {
            UIGraphicsEndImageContext()
        }

        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizeTopAlignedToFill(newWidth: CGFloat) -> UIImage? {
            let newHeight = size.height * newWidth / size.width

            let newSize = CGSize(width: newWidth, height: newHeight)

            UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
            draw(in: CGRect(origin: .zero, size: newSize))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage
        }
}

/* text color gradient */
extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = bounds
         gradientLayer.colors = colors.map(\.cgColor)
         // This makes it left to right, default is top to bottom
         gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
         gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

         let renderer = UIGraphicsImageRenderer(bounds: bounds)

         return renderer.image { ctx in
             gradientLayer.render(in: ctx.cgContext)
         }
     }
}
