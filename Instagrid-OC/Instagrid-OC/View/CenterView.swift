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
    
    @IBOutlet private var upLeftButton: UIButton?
    @IBOutlet private var upRightButton: UIButton?
    @IBOutlet private var downLeftButton: UIButton?
    @IBOutlet private var downRightButton: UIButton?
    
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
