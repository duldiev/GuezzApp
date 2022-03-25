//
//  ViewController.swift
//  Guezz
//
//  Created by Raiymbek Duldiev on 27.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
      
        var shouldMoveViewUp = false

        if let activeTextField = nameTextField {

            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;

            let topOfKeyboard = self.view.frame.height - keyboardSize.height

            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }

        if shouldMoveViewUp {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let destinationVC = segue.destination as! GameViewController
            if nameTextField.text != "" {
                destinationVC.guessBrain.name = nameTextField.text ?? "Unknown"
            }
        }
    }
}

//MARK: - UITextFieldDelegate

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        playButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.placeholder = "Enter your name"
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        playButton.isEnabled = true
    }
}
