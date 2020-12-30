//
//  GameViewController.swift
//  XO
//
//  Created by Khlood on 12/8/20.
//  Copyright © 2020 Khlood. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var firstPlayerNameLabel: UILabel!
    @IBOutlet var secondPlayerNameLabel: UILabel!
    @IBOutlet var firstPlayerScoreLabel: UILabel!
    @IBOutlet var secondPlayerScoreLabel: UILabel!
    @IBOutlet var playingButton: [UIButton]!
    var board = [String]()
    var winningArray = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var enteredFirstPlayerName: String = ""
    var enteredSecondPlayerName: String = ""
    var firstPlayerScore: Int = 0
    var secondPlayerScore = 0
    var clickCount = 0
    var turn1 = ""
    var turn2 = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        firstPlayerNameLabel.text = "\(enteredFirstPlayerName.trimmingCharacters(in: .whitespaces))"
        secondPlayerNameLabel.text = "\(enteredSecondPlayerName.trimmingCharacters(in: .whitespaces))"
        firstPlayerScoreLabel.text = "\(firstPlayerScore)"
        secondPlayerScoreLabel.text = "\(secondPlayerScore)"
        loadBoard()
    }
    
    func loadBoard() {
        for _ in 0..<playingButton.count {
            board.append("")
        }
    }
    
    @IBAction func playingButtonClicked(_ sender: UIButton) {
        let index = playingButton.firstIndex(of: sender)!
        if !board[index].isEmpty {
            return
        }
        switch appDelegate.oneOrTwoPlayersButtonTag
        {
        case 1:
            sender.setTitle(turn1, for: .normal)
            board[index] = turn1
            enableButtons(isEnable: false) // waiting for computer to play
            getTurn2(turn1: turn1)
            _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {_ in
                self.enableButtons(isEnable: true)
                if self.board.contains("") {
                    self.computerTurn(turn2: self.turn2)
                    self.checkGameStatus()
            }
        }
        case 2:
            clickCount += 1
            if clickCount % 2 != 0 {
                sender.setTitle(turn1, for: .normal)
                board[index] = turn1
            } else {
                getTurn2(turn1: turn1)
                sender.setTitle(turn2, for: .normal)
                board[index] = turn2
            }
        default:
            break
        }
        checkGameStatus()
    }
    
    func enableButtons(isEnable: Bool) {
        for btn in playingButton {
            btn.isEnabled = isEnable
        }
    }
    
    func getTurn2 (turn1: String) -> String {
        if turn1 == "X" {
            turn2 = "O"
        } else if turn1 == "O" {
            turn2 = "X"
        }
        return turn2
    }
    
    func computerTurn(turn2: String) {
        var randomNum = Int.random(in: 0 ..< board.count)
        while !board[randomNum].isEmpty {
            randomNum = Int.random(in: 0 ..< board.count)
        }
        let button = playingButton[randomNum]
        button.setTitle(turn2, for: .normal)
        board[randomNum] = turn2
    }
    
    func checkGameStatus() {
        for winning in winningArray {
            let playerAt0 = board[winning[0]]
            let playerAt1 = board[winning[1]]
            let playerAt2 = board[winning[2]]

            if playerAt0 == playerAt1 && playerAt1 == playerAt2 && !playerAt0.isEmpty {
                if playerAt0 == turn1 {
                    firstPlayerScore += 1
                    firstPlayerScoreLabel.text = "\(firstPlayerScore)"
                    showAlert(title: "", msg: "\(firstPlayerNameLabel.text ?? "") لقد فزت ")
                    let button0 = playingButton[winning[0]]
                    let button1 = playingButton[winning[1]]
                    let button2 = playingButton[winning[2]]
                    button0.setTitleColor(#colorLiteral(red: 0.3691387177, green: 0.7839106917, blue: 0.8685053587, alpha: 1), for: .normal) // red line pic animated
                    button1.setTitleColor(#colorLiteral(red: 0.3690254533, green: 0.7858741665, blue: 0.8677309966, alpha: 1), for: .normal)
                    button2.setTitleColor(#colorLiteral(red: 0.3690254533, green: 0.7858741665, blue: 0.8677309966, alpha: 1), for: .normal)
                } else {
                    secondPlayerScore += 1
                    secondPlayerScoreLabel.text = "\(secondPlayerScore)"
                    showAlert(title: "", msg: "\(secondPlayerNameLabel.text ?? "") لقد فزت ")
                    let button0 = playingButton[winning[0]]
                    let button1 = playingButton[winning[1]]
                    let button2 = playingButton[winning[2]]
                    button0.setTitleColor(#colorLiteral(red: 0.3690254533, green: 0.7858741665, blue: 0.8677309966, alpha: 1), for: .normal) // red line pic animated
                    button1.setTitleColor(#colorLiteral(red: 0.3690254533, green: 0.7858741665, blue: 0.8677309966, alpha: 1), for: .normal)
                    button2.setTitleColor(#colorLiteral(red: 0.3690254533, green: 0.7858741665, blue: 0.8677309966, alpha: 1), for: .normal)
                }
                // to stop computer turn when game ends
                for i in 0..<playingButton.count {
                    board[i] = "i"
                }
                return
            }
        }
        if !board.contains("") {
            showAlert(title: "تعادل", msg: "")
        }
    }
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        let continueTheGameAction = UIAlertAction(title: "اكمل اللعب", style: .default) { _ in
            self.playAgain()
        }
        let exitTheGameAction = UIAlertAction(title: "خروج", style: .default) { (UIAlertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(continueTheGameAction)
        alert.addAction(exitTheGameAction)
        present(alert, animated: true, completion: nil)
    }
    
    func playAgain(){
        clickCount = 0
        board.removeAll()
        loadBoard()
        for button in playingButton {
            button.setTitle("", for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
        }
    }
}
