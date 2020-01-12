//
//  CenterView.swift
//  Instagrid-OC
//
//  Created by Melissa GS on 08/12/2019.
//  Copyright © 2019 Goglow. All rights reserved.
//

import UIKit

// A class to customize my CenterView.
class CenterView: UIView {

    var style: Int = 3 {
        didSet {
            setStyle(style)
        }
    }
    // Three layouts and three configurations of images : some buttons must be hidden.
    @IBOutlet weak var upLeftButton: UIButton?
    @IBOutlet weak var upRightButton: UIButton?
    @IBOutlet weak var downLeftButton: UIButton?
    @IBOutlet weak var downRightButton: UIButton?
    
    private func setStyle(_ style: Int) {
        switch style {
        // 1 - A large image at the top and two small images at the bottom.
        case 1:
            upLeftButton?.isHidden = true
            upRightButton?.isHidden = false
            downLeftButton?.isHidden = false
            downRightButton?.isHidden = false
        // 2 - Two small images at the top and a large image at the bottom.
        case 2:
            upLeftButton?.isHidden = false
            upRightButton?.isHidden = false
            downLeftButton?.isHidden = true
            downRightButton?.isHidden = false
        // 3 - Four small images : two at the top and two at the bottom.
        case 3:
            upLeftButton?.isHidden = false
            upRightButton?.isHidden = false
            downLeftButton?.isHidden = false
            downRightButton?.isHidden = false
        default:
            break
        }
    }
}
// An extension to convert a UIView to an image.
extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
