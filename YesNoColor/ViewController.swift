//
//  ViewController.swift
//  YesNoColor
//
//  Created by Supanut Apikulvanich on 6/13/2558 BE.
//  Copyright © 2558 Supanut Apikulvanich. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var timeViewZone: UIView!
    @IBOutlet weak var scoreViewZone: UIView!
    
    @IBOutlet weak var labelTimeRemaining: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    var gameStatus: String = "";
    var timeRemainging: Int = 0;
    var score: Int = 0;
    var timerControl = NSTimer();
    
    var colorsUI: [UIColor] = [UIColor.blueColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.orangeColor(), UIColor.purpleColor(), UIColor.blackColor(), UIColor.brownColor(), UIColor.grayColor()];
    
    var colorsQuestion: [String] = ["Blue", "Red", "Green", "Yellow", "Orange", "Purple", "Black", "Brown", "Grey"];
    
    var indexColor: Int = 0;
    var indexText: Int = 0;


    @IBOutlet weak var labelQuestion: UILabel!
    @IBAction func answerAction(sender: AnyObject) {
        if (self.gameStatus == "Ready" && sender.tag == 0) {
            self.gameStart();
        }
        else if (self.gameStatus == "Playing") {
            if (sender.tag == 0) { // yes
                if (self.indexColor == self.indexText) {
                    self.score++;
                    self.playSoundWithFile("correct");
                }
                else {
                    self.score--;
                    self.playSoundWithFile("wrong");
                }
                self.playSoundWithFile("yes");
            }
            else if (sender.tag == 1) {
                if (self.indexColor != self.indexText) {
                    self.score++;
                    self.playSoundWithFile("correct");
                }
                else {
                    self.score--;
                    self.playSoundWithFile("wrong");
                }
                self.playSoundWithFile("no");
            }
            self.randomQuestion();
            
        }
    }
    
    func randomQuestion() {
        let allQ: Int = colorsQuestion.count;
        self.indexColor = Int(rand()) % allQ;
        self.indexText = Int(rand()) % allQ;
        print("Color = \(self.indexColor), Text = \(self.indexText)");
        if (Int(rand()) % 2 == 1) {
            self.indexColor = self.indexText;
        }
        self.labelQuestion.text = self.colorsQuestion[self.indexText];
        self.labelQuestion.textColor = self.colorsUI[self.indexColor];
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameReady();
        

    }
    
    
    func playSoundWithFile(soundName: String) {
        let soundURL = NSBundle.mainBundle().URLForResource(soundName, withExtension: "mp3")
        var mySound: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL!, &mySound)
        AudioServicesPlaySystemSound(mySound);
    }

    func gameReady() {
        self.scoreViewZone.backgroundColor = UIColor.yellowColor();
        self.timeViewZone.backgroundColor = UIColor.greenColor();
        self.gameStatus = "Ready";
        self.timeRemainging = 30;
        self.labelTimeRemaining.text = "\(self.timeRemainging)";
        self.labelQuestion.text = "R U Ready ?";
        self.labelQuestion.textColor = UIColor.blackColor();
        self.timerControl.invalidate();
    }
    
    func gameStart() {
        self.gameStatus = "Playing";
        self.timeRemainging = 30;
        self.score = 0;
        self.randomQuestion();
        self.timerControl = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "gameLoop", userInfo: nil, repeats: true);
    }
    
    func gameLoop() {
        self.timeRemainging--;
        print(self.timeRemainging);
        self.labelTimeRemaining.text = "\(self.timeRemainging)";
        self.labelScore.text = "\(self.score)";
        self.isGameEnd();
    }
    
    func isGameEnd() {
        if (self.timeRemainging == 0) {
            //self.playSoundWithFile("marioLose.mp3");
            self.playSoundWithFile("marioLose");
            self.gameReady();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

