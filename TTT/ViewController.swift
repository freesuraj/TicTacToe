//
//  ViewController.swift
//  TTT
//
//  Created by Suraj Pathak on 24/3/17.
//  Copyright © 2017 Suraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var playerO: UILabel!
    @IBOutlet weak var playerX: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var view1: UILabel!
    @IBOutlet weak var view2: UILabel!
    @IBOutlet weak var view3: UILabel!
    @IBOutlet weak var view4: UILabel!
    @IBOutlet weak var view5: UILabel!
    @IBOutlet weak var view6: UILabel!
    @IBOutlet weak var view7: UILabel!
    @IBOutlet weak var view8: UILabel!
    @IBOutlet weak var view9: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var currentPlayer: Player! {
        didSet {
            let labelToHighlight = currentPlayer == .playerO ? playerO : playerX
            let labelToUnhighlight = currentPlayer == .playerO ? playerX : playerO
            labelToHighlight?.highlight(color: currentPlayer.color)
            labelToUnhighlight?.unhighlight()
        }
    }
    
    var winState: WinState = .normal {
        didSet {
            infoLabel.text = winState.text
            if case .win(_) = winState {
                highlightWinningCombination()
                toggleGame(false)
            }
            if case .tie = winState {
                toggleGame(false)
            }
        }
    }
    
    let engine = TTT()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleGame(true)
        reset()
        container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        resetButton.addTarget(self, action: #selector(reset), for: .primaryActionTriggered)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tapped(sender: UITapGestureRecognizer) {
        let point = sender.location(in: container)
        let tappedView = container.hitTest(point, with: nil)
        if let label = tappedView as? UILabel {
            let value = label.tag - 1
            guard engine.isValid(value) else { return }
            let state = TicTacState.normal(player: currentPlayer)
            setState(state: state, forLabel: label)
            let didWin = engine.add(value, playerA: currentPlayer == .playerO)
            if didWin {
                winState = .win(player: currentPlayer)
            } else if engine.isTie() {
                winState = .tie
            } else {
                changePlayer()
            }
        }
    }
    
    func toggleGame(_ on: Bool) {
        container.isUserInteractionEnabled = on
        resetButton.setTitle(on ? "Reset" : "New Game", for: .normal)
    }
    
    func reset() {
        currentPlayer = .playerO
        winState = .normal
        for view in container.subviews {
            if let label = view as? UILabel {
                label.unhighlight()
                label.setAnimatedText("")
            }
        }
        engine.reset()
        toggleGame(true)
    }
    
    // MARK: Game Logic
    func changePlayer() {
        currentPlayer = currentPlayer == .playerO ? .playerX : .playerO
    }
    
    func setState(state: TicTacState, forLabel label: UILabel) {
        label.setAnimatedText(state.text, color: state.color)
        if case .win(_) = state {
            label.highlight(color: state.color)
        }
    }
    
    func highlightWinningCombination() {
        let winningSet = engine.winningSet
        for view in container.subviews {
            if let label = view as? UILabel, winningSet.contains(label.tag - 1) {
                setState(state: TicTacState.win(player: currentPlayer), forLabel: label)
            }
        }
    }

}

