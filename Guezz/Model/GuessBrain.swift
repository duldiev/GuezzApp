//
//  GuessBrain.swift
//  Guezz
//
//  Created by Raiymbek Duldiev on 28.02.2022.
//

import Foundation

struct GuessBrain {
    var currentSong: Int = -1
    var isCorrect: Bool = false
    var name: String = "Unknown"
    var score: Int = 0
    var progress: Float = 0.0
    var xp: Int = 0
    
    var whichSong: String {
        return "\(currentSong + 1)/3"
    }
    
    let quiz = [
        Guess(songTitle: "Break From Toronto", artist: "PARTYNEXTDOOR", variants: ["Change Location", "Don't", "Flex"]),
        Guess(songTitle: "Father Stretch My Hands", artist: "Kanye West", variants: ["4:44", "That Part", "30 Hours"]),
        Guess(songTitle: "The Motion", artist: "Drake", variants: ["Connect", "Come Thru", "Controlla"])
    ]
    
    func getXP() -> String {
        return "+\(xp)XP"
    }
    
    func getVariants(_ index: Int) -> String {
        return quiz[currentSong].variants[index]
    }
    
    mutating func addScore() {
        score += xp
    }
    
    func getScore() -> String {
        return String(format: "%.0f", score)
    }
    
    func getSongTitle() -> String {
        return quiz[currentSong].songTitle
    }
    
    func getArtist() -> String {
        return quiz[currentSong].artist
    }
    
    mutating func userAnswers(_ userSong: String) {
        if quiz[currentSong].songTitle == userSong {
            self.isCorrect = true
        } else {
            self.isCorrect = false
            self.xp = 0
        }
    }
    
    mutating func nextSong() {
        currentSong += 1
    }
    
    func isFinished() -> Bool {
        return currentSong + 1 > 2 ? true : false
    }
}
