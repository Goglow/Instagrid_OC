//
//  LayoutView.swift
//  Instagrid-OC
//
//  Created by Melissa GS on 08/12/2019.
//  Copyright © 2019 Goglow. All rights reserved.
//

import UIKit

// A class to customize my LayoutView.
class LayoutView: UIStackView {

    var style: Int = 3 {
        didSet {
            setStyle(style)
        }
    }
    // Like the three configurations, there are three layouts.
    @IBOutlet private var leftButton: UIButton?
    @IBOutlet private var centerButton: UIButton?
    @IBOutlet private var rightButton: UIButton?
    
    // When a layout is selected, the configuration must match and a "Selected" image must appear.
    private func setStyle(_ style: Int) {
        switch style {
        // 1 - A large image at the top and two small images at the bottom.
        case 1:
            leftButton!.setImage(UIImage(named: "Selected"), for: .normal)
            leftButton!.imageView?.contentMode = .scaleAspectFill
            centerButton?.setImage(nil, for: .normal)
            rightButton?.setImage(nil, for: .normal)
            print("Layout 1")
        // 2 - Two small images at the top and a large image at the bottom.
        case 2:
            centerButton!.setImage(UIImage(named: "Selected"), for: .normal)
            centerButton!.imageView?.contentMode = .scaleAspectFill
            leftButton?.setImage(nil, for: .normal)
            rightButton?.setImage(nil, for: .normal)
            print("Layout 2")
        // 3 - Four small images : two at the top and two at the bottom.
        case 3:
            rightButton!.setImage(UIImage(named: "Selected"), for: .normal)
            rightButton!.imageView?.contentMode = .scaleAspectFill
            leftButton?.setImage(nil, for: .normal)
            centerButton?.setImage(nil, for: .normal)
            print("Layout 3")
        default:
            break
        }
    }
}
