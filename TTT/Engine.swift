//
//  Engine.swift
//  TTT
//
//  Created by Suraj Pathak on 24/3/17.
//  Copyright © 2017 Suraj. All rights reserved.
//

import Foundation

class TTT {
    private var playerA: String = "A"
    private var playerB: String = "B"
    
    var playerAPoints: Set<Int> = []
    var playerBPoints: Set<Int> = []
    
    var winningSet: Set<Int> = []
    
    let wins: Set<Set<Int>> = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    init() {
    }
    
    func isValid(_ value: Int) -> Bool {
        guard value < 9, !playerAPoints.contains(value), !playerBPoints.contains(value) else { return false }
        return true
    }
    
    func isTie() -> Bool {
        return playerAPoints.count + playerBPoints.count == 9
    }
    
    func add(_ value: Int, playerA: Bool) -> Bool {
        guard isValid(value) else { return false }
        if playerA {
            playerAPoints.insert(value)
        } else {
            playerBPoints.insert(value)
        }
        
        let playerPoints = playerA ? playerAPoints : playerBPoints
        return checkWinner(playerPoints: playerPoints)
    }
    
    func checkWinner( playerPoints: Set<Int>) -> Bool {
        for combination in wins {
            if combination.isSubset(of: playerPoints) {
                winningSet = combination
                return true
            }
        }
        return false
    }
    
    func reset() {
        playerAPoints = []
        playerBPoints = []
        winningSet = []
    }
    
}
