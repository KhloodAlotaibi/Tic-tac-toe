//
//  PlayersInfoViewController.swift
//  XO
//
//  Created by Khlood on 12/8/20.
//  Copyright © 2020 Khlood. All rights reserved.
//

import UIKit

class PlayersInfoViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var firstPlayerNameTextField: UITextField!
    @IBOutlet var secondPlayerNameTextField: UITextField!
    @IBOutlet var firstMoveSegmentControl: UISegmentedControl!
    @IBOutlet var MissingInputWarningLabel: UILabel!
    @IBOutlet var startGameButton: UIButton!
    var selectedFirstMove: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if appDelegate.oneOrTwoPlayersButtonTag == 1 {
            secondPlayerNameTextField.isEnabled = false
            secondPlayerNameTextField.text = "Computer"
            secondPlayerNameTextField.textColor = .gray
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameButton.applyDesign()
    }
    
    @IBAction func startGameButtonClicked(_ sender: Any) {
        if firstPlayerNameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || secondPlayerNameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty || firstMoveSegmentControl.selectedSegmentIndex == -1 {
            MissingInputWarningLabel.text = "نسيت اسماء اللاعبين/الحركة الاولى"
            MissingInputWarningLabel.textColor = .red
            MissingInputWarningLabel.isHidden = false
        } else {
            MissingInputWarningLabel.isHidden = true
            performSegue(withIdentifier: "gameSegue", sender: self)
        }
    }
    
    @IBAction func firstMoveSegmentControlSelected (_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedFirstMove = "X"
        } else {
            selectedFirstMove = "O"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! GameViewController
        controller.enteredFirstPlayerName = firstPlayerNameTextField.text ?? ""
        controller.enteredSecondPlayerName = secondPlayerNameTextField.text ?? ""
        controller.turn1 = selectedFirstMove
    }
}
