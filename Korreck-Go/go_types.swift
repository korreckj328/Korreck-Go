//
//  go_types.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 1/24/21.
//

import Foundation

enum PlayerColor {
    case black
    case white
}


struct Situation: Equatable {
    static func == (lhs: Situation, rhs: Situation) -> Bool {
        return lhs.nextPlayer == rhs.nextPlayer && lhs.board == rhs.board
    }
    
    var nextPlayer: Player
    var board: Board
}


