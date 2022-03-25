//
//  GameViewController.swift
//  Guezz
//
//  Created by Raiymbek Duldiev on 28.02.2022.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var timerBar: UIProgressView!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    var guessBrain = GuessBrain()
    
    var timer = Timer()
    
    var player: AVAudioPlayer!
    
    var secondsRemaining = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        
        timer.invalidate()
        
        if !guessBrain.isFinished() {
            guessBrain.nextSong()
        }
        
        userNameLabel.text = guessBrain.name
        
        timerBar.progress = 1.0
        
        albumCoverImage.image = UIImage(named: guessBrain.getSongTitle())
        
        firstButton.setTitle(guessBrain.getVariants(0), for: .normal)
        secondButton.setTitle(guessBrain.getVariants(1), for: .normal)
        thirdButton.setTitle(guessBrain.getSongTitle(), for: .normal)
        fourthButton.setTitle(guessBrain.getVariants(2), for: .normal)
        
        playSound(soundName: guessBrain.getSongTitle())
        
        secondsRemaining = 30
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func playSound(soundName: String) {
        
        
        
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        
        player = try! AVAudioPlayer(contentsOf: url!)
        
        player.play()
    }

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        showAlertWithDistructiveButton()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {

        if let title = sender.titleLabel?.text {
            guessBrain.userAnswers(title)
        }
        
        player.pause()
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            timerBar.progress = (Float(secondsRemaining) / 30.0)
            guessBrain.xp = Int((Float(secondsRemaining) / 30) * 100)
        } else {
            timer.invalidate()
            guessBrain.userAnswers("No answer")
            player.pause()
            performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.guessBrain = guessBrain
            destinationVC.instanceOfGameVC = self
        }
    }
    
    func showAlertWithDistructiveButton() {
        let alert = UIAlertController(title: "Leaving the game?", message: "", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Leave",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
            self.player.pause()
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
