//
//  Action.swift
//  Instagrid-OC
//
//  Created by Melissa GS on 24/12/2019.
//  Copyright © 2019 Goglow. All rights reserved.
//

import Foundation

class Action {
    var state: State = .ongoing

    enum State {
        case ongoing, over
    }
}
