//
//  Player.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 1/24/21.
//

import Foundation

enum PlayerType {
    case Human
    case RandomAgent
}

class Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.playerColor == rhs.playerColor && lhs.other == rhs.other
    }
    
    var playerColor: PlayerColor
    var other: Player?
    var agent: RandomBot?
    
    init(pc: PlayerColor) {
        playerColor = pc
        agent = nil
    }
    
    func setOther(player: Player) {
        other = player
    }
    
    func setAgent(pType: PlayerType) {
        if pType == PlayerType.RandomAgent {
            agent = RandomBot()
        }
    }
}
