//
//  LayoutView.swift
//  Instagrid-OC
//
//  Created by Melissa GS on 08/12/2019.
//  Copyright © 2019 Goglow. All rights reserved.
//

import UIKit

class LayoutView: UIStackView {

    var style: Int = 3 {
        didSet {
            setStyle(style)
        }
    }

    @IBOutlet private var leftButton: UIButton?
    @IBOutlet private var centerButton: UIButton?
    @IBOutlet private var rightButton: UIButton?
    
    private func setStyle(_ style: Int) {
        switch style {
        case 1:
            leftButton!.setImage(UIImage(named: "Selected"), for: .normal)
            leftButton!.imageView?.contentMode = .scaleAspectFill
            centerButton?.setImage(nil, for: .normal)
            rightButton?.setImage(nil, for: .normal)
            print("Layout 1")
        case 2:
            centerButton!.setImage(UIImage(named: "Selected"), for: .normal)
            centerButton!.imageView?.contentMode = .scaleAspectFill
            leftButton?.setImage(nil, for: .normal)
            rightButton?.setImage(nil, for: .normal)
            print("Layout 2")
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
