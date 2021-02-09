//
//  Move.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 1/24/21.
//

import Foundation

class Move {
    var point:Point?
    var play:Bool
    var pass:Bool
    var conceed:Bool
    
    
    
    init(movePoint:Point?, movePass:Bool = false, moveConceed:Bool = false) {
        point = movePoint
        play = (point != nil)
        pass = movePass
        conceed = moveConceed
    }
    
    static func play(point: Point) -> Move {
        return Move(movePoint: point)
    }
    
    static func passTurn() -> Move {
        return Move(movePoint: nil, movePass: true)
    }
    
    static func conceedGame() -> Move {
        return Move(movePoint: nil, moveConceed: true)
    }
}
