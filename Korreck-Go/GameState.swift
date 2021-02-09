//
//  GameState.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 1/26/21.
//

import Foundation

class GameState {
    var board: Board
    var nextPlayer: Player
    var previousState: GameState?
    var lastMove: Move?
    
    init(boardSize: Int, blackPlayer: Player) {
        board = Board(numRows: boardSize, numCol: boardSize)
        nextPlayer = blackPlayer
        previousState = nil
        lastMove = nil
    }
    
    init(newboard: Board, next_Player: Player, previous_state: GameState?, move: Move?) {
        board = newboard
        nextPlayer = next_Player
        previousState = previous_state
        lastMove = move
    }
    
    func isMoveSelfCapture(player: Player, move: Move) -> Bool {
        if !move.play {
            return false
        }
        let nextBoard = board
        nextBoard.placeStone(player: player, point: move.point!)
        let goString = nextBoard.getGoString(point: move.point!)
        return goString?.numLiberties() == 0
    }
    
    func situation() -> Situation {
        return Situation(nextPlayer: nextPlayer, board: board)
    }
    
    func isValidMove(move: Move) -> Bool {
        if isOver() {
            return false
        }
        if move.pass || move.conceed {
            return true
        }
        return board.get(point: move.point!) == nil && !isMoveSelfCapture(player: nextPlayer, move: move) && !doesMoveViolateKo(player: nextPlayer, move: move)
    }
    
    func doesMoveViolateKo(player: Player, move: Move) -> Bool {
        if !move.play {
            return false
        }
        let nextBoard = board
        nextBoard.placeStone(player: player, point: move.point!)
        let nextSituation = Situation(nextPlayer: player.other!, board: nextBoard)
        guard let pastState = previousState else {
            return false
        }
        
        if pastState.situation() == nextSituation {
            return true
        }
        return false
    }
    
    func isOver() -> Bool {
        guard let lm = lastMove else {
            return false
        }
        if lm.conceed {
            return true
        }
        
        guard let secondLastMove = previousState?.lastMove else {
            return false
        }
        
        return lm.pass && secondLastMove.pass
        
    }
    
    func applyMove(move: Move) -> GameState {
        var nextBoard: Board
        if move.play {
            nextBoard = board
            nextBoard.placeStone(player: nextPlayer, point: move.point!)
        } else {
            nextBoard = board
        }
        return GameState(newboard: nextBoard, next_Player: nextPlayer.other!, previous_state: self, move: move)
    }
    
}
