//
//  CenterView.swift
//  Instagrid-OC
//
//  Created by Melissa GS on 08/12/2019.
//  Copyright © 2019 Goglow. All rights reserved.
//

import UIKit

class CenterView: UIView {

    var style: Int = 3 {
        didSet {
            setStyle(style)
        }
    }
    
    @IBOutlet weak var upLeftButton: UIButton?
    @IBOutlet weak var upRightButton: UIButton?
    @IBOutlet weak var downLeftButton: UIButton?
    @IBOutlet weak var downRightButton: UIButton?
    
    private func setStyle(_ style: Int) {
        switch style {
        case 1:
            upLeftButton?.isHidden = true
            upRightButton?.isHidden = false
            downLeftButton?.isHidden = false
            downRightButton?.isHidden = false
        case 2:
            upLeftButton?.isHidden = false
            upRightButton?.isHidden = false
            downLeftButton?.isHidden = true
            downRightButton?.isHidden = false
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

extension UIView {
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
