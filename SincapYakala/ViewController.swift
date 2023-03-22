//
//  ViewController.swift
//  SincapYakala
//
//  Created by imrahor on 20.02.2023.
//

import UIKit

class ViewController: UIViewController {

    //variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var sincapDizisi = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var sincap1: UIImageView!
    @IBOutlet weak var sincap2: UIImageView!
    @IBOutlet weak var sincap3: UIImageView!
    @IBOutlet weak var sincap4: UIImageView!
    @IBOutlet weak var sincap5: UIImageView!
    @IBOutlet weak var sincap6: UIImageView!
    @IBOutlet weak var sincap7: UIImageView!
    @IBOutlet weak var sincap8: UIImageView!
    @IBOutlet weak var sincap9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Images
        
        scoreLabel.text = "Score: \(score)"
        
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore != nil {
            if let storedHighScore = storedHighScore as? Int {
                highScoreLabel.text = "\(storedHighScore)"
            } else {
                highScoreLabel.text = "0"
            }
            
        }
        
        
        sincap1.isUserInteractionEnabled = true
        sincap2.isUserInteractionEnabled = true
        sincap3.isUserInteractionEnabled = true
        sincap4.isUserInteractionEnabled = true
        sincap5.isUserInteractionEnabled = true
        sincap6.isUserInteractionEnabled = true
        sincap7.isUserInteractionEnabled = true
        sincap8.isUserInteractionEnabled = true
        sincap9.isUserInteractionEnabled = true
       
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        sincap1.addGestureRecognizer(gestureRecognizer1)
        sincap2.addGestureRecognizer(gestureRecognizer2)
        sincap3.addGestureRecognizer(gestureRecognizer3)
        sincap4.addGestureRecognizer(gestureRecognizer4)
        sincap5.addGestureRecognizer(gestureRecognizer5)
        sincap6.addGestureRecognizer(gestureRecognizer6)
        sincap7.addGestureRecognizer(gestureRecognizer7)
        sincap8.addGestureRecognizer(gestureRecognizer8)
        sincap9.addGestureRecognizer(gestureRecognizer9)
        
        sincapDizisi = [sincap1, sincap2, sincap3, sincap4, sincap5, sincap6, sincap7, sincap8, sincap9]
        
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideSincap), userInfo: nil, repeats: true)
      
        hideSincap()
    }
    
    @objc func hideSincap() {
        for sincap in sincapDizisi {
            sincap.isHidden = true
        }
        let randomSincap = Int(arc4random_uniform(UInt32(sincapDizisi.count - 1)))
        sincapDizisi[randomSincap].isHidden = false
        
    }

    @objc func increaseScore() {
        score += 1
        scoreLabel.text = String(score)
    }
    
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            
            if self.score > self.highScore {
                self.highScore = self.score
                self.highScoreLabel.text = String(self.highScore)
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }

            let alert = UIAlertController(title: "Time's up", message: "do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "REPLAY", style: UIAlertAction.Style.default) { action in
                
                self.score = 0
                self.scoreLabel.text = String(self.score)
                
                self.counter = 10
                self.timeLabel.text = String(self.score)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideSincap), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
            
        }
        
}

