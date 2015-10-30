//
//  CustomLabel.swift
//  Flockr Cam
//
//  Created by Matheus Frozzi Alberton on 27/10/15.
//  Copyright © 2015 720. All rights reserved.
//

import UIKit

class MaskedLabel: UILabel {
    
    var maskColor : UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }

    func customInit() {
        maskColor = self.backgroundColor
        self.textColor = UIColor.whiteColor()
        backgroundColor = UIColor.clearColor()
        self.opaque = false
    }

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        super.drawRect(rect)

        CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, CGRectGetHeight(rect)))

        let image: CGImageRef = CGBitmapContextCreateImage(context)!
        let mask: CGImageRef = CGImageMaskCreate(CGImageGetWidth(image), CGImageGetHeight(image), CGImageGetBitsPerComponent(image), CGImageGetBitsPerPixel(image), CGImageGetBytesPerRow(image), CGImageGetDataProvider(image), CGImageGetDecode(image), CGImageGetShouldInterpolate(image))!

        CGContextClearRect(context, rect)
        
        CGContextSaveGState(context)
        CGContextClipToMask(context, rect, mask)
        
        if (self.layer.cornerRadius != 0.0) {
            CGContextAddPath(context, CGPathCreateWithRoundedRect(rect, self.layer.cornerRadius, self.layer.cornerRadius, nil))
            CGContextClip(context)
        }

        drawBackgroundInRect(rect)
        CGContextRestoreGState(context)
    }

    func drawBackgroundInRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        if let _ = maskColor {
            maskColor!.set()
        }

        CGContextFillRect(context, rect)
    }
}
