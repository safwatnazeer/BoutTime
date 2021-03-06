//
//  ViewController.swift
//  BoutTime
//
//  Created by Safwat Shenouda on 11/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // game variabels and constants
    let boutTime = BoutTime()       //
    var timer = NSTimer()           // timer object
    var timeLeft = 0                // time left for round to complete
    
    
    // outlets
    
    @IBOutlet weak var firstTextButton: UIButton!
    @IBOutlet weak var secondTextButton: UIButton!
    @IBOutlet weak var thirdTextButton: UIButton!
    @IBOutlet weak var fourthTextButton: UIButton!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var shakeLabel: UILabel!
    
    // Control buttons outlets to enable and disable buttons at round end
    @IBOutlet weak var firstRowButton: UIButton!
    @IBOutlet weak var secondRowButtonUp: UIButton!
    @IBOutlet weak var secondRowButtonDown: UIButton!
    @IBOutlet weak var thirdRowButtonUp: UIButton!
    @IBOutlet weak var thirdRowButtonDown: UIButton!
    @IBOutlet weak var fourthRowButton: UIButton!
    
    
    
    // MARK: Game controls
    @IBAction func buttonFirst() {
        boutTime.swapCurrentRoundData(0, index2: 1)
        showEvents()
        
    }
    @IBAction func buttonSecondUp() {
        boutTime.swapCurrentRoundData(0, index2: 1)
        showEvents()
    }
    @IBAction func buttonSecondDown() {
        boutTime.swapCurrentRoundData(1, index2: 2)
        showEvents()
    }
    @IBAction func buttonsThirdUp() {
        boutTime.swapCurrentRoundData(1, index2: 2)
        showEvents()
    }
    @IBAction func buttonThirdDown() {
        boutTime.swapCurrentRoundData(2, index2: 3)
        showEvents()
    }
    @IBAction func buttonFourth() {
        boutTime.swapCurrentRoundData(2, index2: 3)
        showEvents()
    }

    
    // MARK: Core game play
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextButton.titleLabel?.numberOfLines = 4
        secondTextButton.titleLabel?.numberOfLines = 4
        thirdTextButton.titleLabel?.numberOfLines = 4
        fourthTextButton.titleLabel?.numberOfLines = 4
        disableTextButtons()
        nextRound()
        
    }

    
    func showEvents() {
    
        // set button title to the events
        firstTextButton.setTitle(boutTime.currentRoundData[0].event, forState: .Normal)
        secondTextButton.setTitle(boutTime.currentRoundData[1].event, forState: .Normal)
        thirdTextButton.setTitle(boutTime.currentRoundData[2].event, forState: .Normal)
        fourthTextButton.setTitle(boutTime.currentRoundData[3].event, forState: .Normal)
        
    }
    

    // Method to be check results of one round and show button iamge accordingly
    func finishRound() {
        
        // make timer disapper
        timeLeftLabel.hidden = true
        if boutTime.isCorrectOrder() {
           
            // set button green
            nextRoundButton.setImage(UIImage(named: "next_round_success"), forState: .Normal)
        }
        else {
            
            // set button red
            nextRoundButton.setImage(UIImage(named: "next_round_fail"), forState: .Normal)
        }
        // show next round button
        nextRoundButton.hidden = false
        
        //enable text btttons so user can click and see more info
        shakeLabel.text = "Tap event to learn more"
        enableTextButtons()
    }
    
    // Method to intercept the call for segue and check if game is over before showing score view controller
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "finalScoreSegue" {
            if boutTime.isGameOver() {
                return true
            }
            else {
                nextRound()
                return false
            }
        }
        return true
    }
    
    // Method to check which segue is being called and set data accordingly
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // check for show final score segue
        if segue.identifier == "finalScoreSegue" {
            if let controller =  segue.destinationViewController as? ScoreViewController {
                controller.scoreText = boutTime.getFinalScore()
                controller.completionHandler = {
                    self.newGame()
                }
            }
        }
        
        // check for webView segue
        // We determine which button was clicked based on segue identifer and pass the corresponding link
        if segue.identifier == "showWebViewSegue1" {
            if let controller =  segue.destinationViewController as? WebViewController {
                controller.link = boutTime.currentRoundData[0].link
            }
        }
        if segue.identifier == "showWebViewSegue2" {
            if let controller =  segue.destinationViewController as? WebViewController {
                controller.link = boutTime.currentRoundData[1].link
            }
        }
        if segue.identifier == "showWebViewSegue3" {
            if let controller =  segue.destinationViewController as? WebViewController {
                controller.link = boutTime.currentRoundData[2].link
            }
        }
        if segue.identifier == "showWebViewSegue4" {
            if let controller =  segue.destinationViewController as? WebViewController {
                controller.link = boutTime.currentRoundData[3].link
            }
        }

        
                
    }
    
    // Method to start new game
    func newGame(){
        boutTime.prepareNewGame()
        nextRound()
    }
    
    // Method to start a new round
    func nextRound() {
        
            // prepare next round
            boutTime.createRoundData()
            showEvents()
            // hide button 
            nextRoundButton.hidden = true
            // start timer
            startTimer()
            // show timer
            timeLeftLabel.hidden = false
            
            // disable text buttons
            disableTextButtons()
            timeLeftLabel.text = "00:\(boutTime.maxTimeAllowed)"
            shakeLabel.text = "Shake to complete"
        
    }
    
    
    // MARK: Status bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    // MARK: Timer Methods
    
    func startTimer () {
        
        timer.invalidate()
        timeLeft = boutTime.maxTimeAllowed
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func timerAction () {
        
        if timeLeft>0 {
            timeLeft -= 1
            if timeLeft > 9 {
                timeLeftLabel.text = "00:\(timeLeft)"
            }
            else {
                timeLeftLabel.text = "00:0\(timeLeft)"  // make sure we always show two digits for seconds left
            }
        }
        else
        {
            stopTimer()
            finishRound()
        }
        
    }
    
    // MARK: Motion detection
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        self.becomeFirstResponder()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == UIEventSubtype.MotionShake {
            finishRound()
        }
    }

    // MARK: Helper methods
    func disableTextButtons() {
        firstTextButton.enabled = false
        secondTextButton.enabled = false
        thirdTextButton.enabled = false
        fourthTextButton.enabled = false
        
        // enable control buttons 
        firstRowButton.enabled = true
        secondRowButtonUp.enabled = true
        secondRowButtonDown.enabled = true
        thirdRowButtonUp.enabled = true
        thirdRowButtonDown.enabled = true
        fourthRowButton.enabled = true
        
    }
    func enableTextButtons() {
        firstTextButton.enabled = true
        secondTextButton.enabled = true
        thirdTextButton.enabled = true
        fourthTextButton.enabled = true
        
        // disable control buttons so user doesnt move text when round is finished
        firstRowButton.enabled = false
        secondRowButtonUp.enabled = false
        secondRowButtonDown.enabled = false
        thirdRowButtonUp.enabled = false
        thirdRowButtonDown.enabled = false
        fourthRowButton.enabled = false

    }

    
}

