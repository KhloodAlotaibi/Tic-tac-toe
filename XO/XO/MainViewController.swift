//
//  MainViewController.swift
//  XO
//
//  Created by Khlood on 12/8/20.
//  Copyright © 2020 Khlood. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
 
    @IBOutlet var onePlayerButton: UIButton! 
    @IBOutlet var twoPlayersButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onePlayerButton.applyDesign()
        twoPlayersButton.applyDesign()
    }
    
    @IBAction func playerButtonsClicked(_ sender: UIButton) {
        appDelegate.oneOrTwoPlayersButtonTag = sender.tag 
        performSegue(withIdentifier: "getPlayersInfoSegue", sender: sender)
    }
}

extension UIButton {
    func applyDesign () {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
