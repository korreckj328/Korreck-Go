//
//  Helpers.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 2/8/21.
//

import Foundation

func isPointAnEye(board: Board, point: Point, color: PlayerColor) -> Bool {
    if board.get(point: point) != nil {
        return false
    }
    for neighbor in point.neighbors() {
        if board.onGrid(point: neighbor) {
            let neighborColor = board.get(point: neighbor)
            if neighborColor != color {
                return false
            }
        }
    }
    
    var friendlyCorners = 0
    var offBoardCorners = 0
    let corners: [Point] = [
        Point(r: point.row - 1, c: point.col - 1),
        Point(r: point.row - 1, c: point.col + 1),
        Point(r: point.row + 1, c: point.col - 1),
        Point(r: point.row + 1, c: point.col + 1)]
    
    for corner in corners {
        if board.onGrid(point: corner) {
            let cornerColor = board.get(point: corner)
            if cornerColor == color {
                friendlyCorners += 1
            } else {
                offBoardCorners += 1
            }
        }
    }
    if offBoardCorners > 0 {
        return offBoardCorners + friendlyCorners == 4
    }
    return friendlyCorners >= 3
    
}
