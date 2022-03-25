//
//  ResultViewController.swift
//  Guezz
//
//  Created by Raiymbek Duldiev on 28.02.2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var trackerLabel: UILabel!
    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var cheeringMessageLabel: UILabel!
    @IBOutlet weak var earnedPointsLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    
    var instanceOfGameVC: GameViewController!
    
    var guessBrain = GuessBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        
        if guessBrain.isFinished() {
            
        }
        
        artistLabel.text = guessBrain.getArtist()
        songLabel.text = guessBrain.getSongTitle()
        
        if !guessBrain.isCorrect {
            checkMarkImage.image = UIImage(systemName: "x.circle")
            checkMarkImage.tintColor = .red
            cheeringMessageLabel.text = "Wrong!"
            earnedPointsLabel.text = guessBrain.getXP()
        } else {
            checkMarkImage.image = UIImage(systemName: "checkmark.circle")
            checkMarkImage.tintColor = .green
            cheeringMessageLabel.text = "Excelent!"
            earnedPointsLabel.text = guessBrain.getXP()
        }
        
        guessBrain.addScore()
        
        scoreLabel.text = "\(guessBrain.score)"
        trackerLabel.text = guessBrain.whichSong
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if !guessBrain.isFinished() {
            instanceOfGameVC.guessBrain = self.guessBrain
            instanceOfGameVC.viewDidLoad()
        }
        dismiss(animated: true, completion: nil)
    }
    
}
