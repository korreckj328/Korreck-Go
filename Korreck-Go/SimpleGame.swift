//
//  SimpleGame.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 2/8/21.
//

import Foundation

class Game {
    let boardSize = 9
    var playerOne: Player
    var playerTwo: Player
    var board: Board
    var game: GameState
    
    
    init() {
        playerOne = Player(pc: PlayerColor.white)
        playerTwo = Player(pc: PlayerColor.black)
        playerOne.setOther(player: playerTwo)
        playerTwo.setOther(player: playerOne)
        playerOne.setAgent(pType: PlayerType.RandomAgent)
        playerTwo.setAgent(pType: PlayerType.RandomAgent)
        board = Board(numRows: boardSize, numCol: boardSize)
        game = GameState(boardSize: boardSize, blackPlayer: playerTwo)
        
    }
    
    func run() {
        while !game.isOver() {
            sleep(1)
            print("............")
            printBoard(board: board)
            let botMove = game.nextPlayer.agent!.selectMove(gameState: game)
            printMove(player: game.nextPlayer, move: botMove)
        }
    }
    
}
