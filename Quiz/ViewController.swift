//
//  ViewController.swift
//  Quiz
//
//  Created by Pascal Hurni on 17.02.16.
//  Copyright (c) 2016 Pascal Hurni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    
    var session : QuizSession!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        resetSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetSession() {
        // Create our game session, and get the first question
        session = QuizSession()
        nextOne()
    }
    
    @IBAction func answerClick(_ sender: UIButton) {
        // Tell the session the chosen answer
        session.checkAnswer(sender.currentTitle!)
        
        // Update labels
        scoreLabel.text = "Score: \(session.score) / \(session.questionCount)"
        
        // Pass to the next question
        nextOne()
    }

    @IBAction func resetGame(_ sender: Any) {
        resetSession()
        
        // Reset the UI
        hintButton.isHidden = false
        scoreLabel.isHidden = true
        answerButton1.isHidden = false
        answerButton2.isHidden = false
        answerButton3.isHidden = false
        resetButton.isHidden = true
    }
    
    @IBAction func showHint(_ sender: Any) {
        let hint = session.hint
        let alert = UIAlertController(title: "Alert", message: hint, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func nextOne() {
        // get the next question from the session
        if let question = session.nextQuestion() {
            // Set the captions
            questionLabel.text = question.caption
            answerButton1.setTitle(question.answers[0], for: UIControlState())
            answerButton2.setTitle(question.answers[1], for: UIControlState())
            answerButton3.setTitle(question.answers[2], for: UIControlState())
        }
        else {
            questionLabel.text = "GAME OVER"
            hintButton.isHidden = true
            
            // Display the score
            scoreLabel.isHidden = false
            
            // No more questions! This is the end
            answerButton1.isHidden = true
            answerButton2.isHidden = true
            answerButton3.isHidden = true
            
            // Prevents text blinks on game session reset
            answerButton1.setTitle("", for: UIControlState())
            answerButton2.setTitle("", for: UIControlState())
            answerButton3.setTitle("", for: UIControlState())
            
            resetButton.isHidden = false
        }
    }
    
}

