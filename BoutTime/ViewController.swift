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
    var gameScore = 0               // current score for previous rounds
    var numberOfRoundsPlayed = 0    // holds how many rounds played so far
    let maxRoundsPerGame = 1        // game has 6 rounds
    let maxTimeAllowed = 10         // round time 60 seconds
    
    // outlets
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var shakeLabel: UILabel!
    
    
    
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

    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        nextRound()
        
    }

    
    func showEvents() {
        firstLabel.text = boutTime.currentRoundData[0].event
        secondLabel.text = boutTime.currentRoundData[1].event
        thirdLabel.text = boutTime.currentRoundData[2].event
        fourthLabel.text = boutTime.currentRoundData[3].event
        
        // check order
        checkOrder()
    }
    
    func checkOrder() -> Bool{
        
        if boutTime.isCorrectOrder() {
            let alert = UIAlertController(title: "Order Correct", message: "You made it, good job", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            return true
        }
        return false
    }
    
    func finishRound() {
        
        // let timer disapper
        timeLeftLabel.hidden = true
        if checkOrder() {
            // set button green
            nextRoundButton.setImage(UIImage(named: "next_round_success"), forState: .Normal)
            // add to score
            gameScore += 1
            
        }
        else {
            // set button red
            nextRoundButton.setImage(UIImage(named: "next_round_fail"), forState: .Normal)
            // dont add to score
            
        }
        // show next round button
        nextRoundButton.hidden = false
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "finalScoreSegue" {
            if numberOfRoundsPlayed < maxRoundsPerGame {
                return false
            }
                    }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finalScoreSegue" {
            if let controller =  segue.destinationViewController as? ScoreViewController {
                controller.scoreText = "\(gameScore)/\(maxRoundsPerGame)"
                controller.completionHandler = {
                    self.newGame()
                }
            }
        }
    }
    
    @IBAction func nextRound() {
        
            // prepare next round
            boutTime.createRoundData()
            showEvents()
            // hide button 
            nextRoundButton.hidden = true
            // start timer
            startTimer()
            // show timer
            timeLeftLabel.hidden = false
            numberOfRoundsPlayed += 1
    }
    
    func newGame(){
        gameScore = 0
        nextRound()
    }
    
    // MARK: Status bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    // MARK: Timer 
    
    func startTimer () {
        
        timer.invalidate()
        timeLeft = maxTimeAllowed
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
                timeLeftLabel.text = "00:0\(timeLeft)"
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
            print("motion shake...")
            finishRound()
        }
    }

    
}

