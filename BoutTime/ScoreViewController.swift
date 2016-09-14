//
//  ScoreViewController.swift
//  BoutTime
//
//  Created by Safwat Shenouda on 14/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

typealias HANDLER = ()->Void

class ScoreViewController: UIViewController {
    
    var completionHandler:HANDLER?
    var scoreText: String?
    
    @IBOutlet weak var scoreLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = scoreText
    }
    
    @IBAction func playAgain() {
        
        if let handeler = completionHandler {
            self.dismissViewControllerAnimated(false, completion: nil)
            handeler()
        }
        else {
            fatalError()
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
