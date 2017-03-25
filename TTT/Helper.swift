//
//  Helper.swift
//  TTT
//
//  Created by Suraj Pathak on 25/3/17.
//  Copyright © 2017 Suraj. All rights reserved.
//

import UIKit

enum Player {
    case playerO
    case playerX
    
    var color: UIColor {
        return self == .playerO ? UIColor.orange: UIColor.blue
    }
    
    var text: String {
        return self == .playerO ? "O" : "X"
    }
}

enum TicTacState {
    case normal(player: Player)
    case win(player: Player)
    
    var color: UIColor {
        switch self {
        case .normal(let p):
            return p.color
        case .win(_):
            return UIColor.red
        }
    }
    
    var text: String {
        switch self {
        case .normal(let p), .win(let p):
            return p.text
        }
    }
}

enum WinState {
    case win(player: Player)
    case tie
    case normal
    
    var text: String {
        switch self {
        case .win(let p):
            return "\(p.text) WINS !!! Congratulations !!"
        case .tie:
            return "TIE GAME !"
        case .normal:
            return "--"
        }
    }
}
