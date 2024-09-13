//
//  MemoryViewModel.swift
//  Memory
//
//  Created by Serena Roderick on 9/11/24.
//

import Foundation

class GameViewModel {
    var imgNames: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "h"]
    var stopwatchTimer: Timer?
    @Published var elapsedTime: TimeInterval = 0
    var isPlaying: Bool = false
    
    init() {
        imgNames.shuffle()
    }
    
    func startGame() {
        self.isPlaying = true
        startTimer()
    }
    
    func startTimer() {
        if let timer = stopwatchTimer {
            timer.invalidate()
            stopwatchTimer = nil
            elapsedTime = 0
            
        } else {
            // Start the timer
            stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] timer in
                guard let self else {return}
                // Update the elapsed time
                self.elapsedTime += timer.timeInterval
                
                // Update the label with the formatted time
            })
        }
    }
    
    func timeFormat() -> String {
        // Format the elapsed time as a stopwatch time
        let minutes = Int(self.elapsedTime) / 60 % 60
        let seconds = Int(self.elapsedTime) % 60
        let milliseconds = Int(self.elapsedTime * 100) % 100
        //print(milliseconds)
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
}
