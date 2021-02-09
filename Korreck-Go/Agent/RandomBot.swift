//
//  RandomBot.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 2/8/21.
//

import Foundation
class RandomBot {
    func selectMove(gameState: GameState) -> Move {
        // choose a random valid move that preserves our own eyes
        var candidates: [Point] = []
        for r in 1 ... gameState.board.numberRows + 1 {
            for c in 1 ... gameState.board.numberColumns + 1 {
                let candidate = Point(r: r, c: c)
                if gameState.isValidMove(move: Move.play(point: candidate)) &&
                    !isPointAnEye(board: gameState.board, point: candidate, color: gameState.nextPlayer.playerColor) {
                    candidates.append(candidate)
                }
            }
        }
        if candidates.isEmpty {
            return Move.passTurn()
        }
        let numberCandidates = candidates.count
        let randomIndex = Int.random(in: 0 ..< numberCandidates)
        return Move.play(point: candidates[randomIndex])
    }
}
