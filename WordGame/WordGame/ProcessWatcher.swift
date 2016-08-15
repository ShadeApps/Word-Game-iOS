//
//  ProcessWatcher.swift
//  WordGame
//
//  Created by Сергей Грищёв on 12.08.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

protocol GameProcessDelegate : NSObjectProtocol{
	func timePassed(timeLeft: Float)
	func gameFinished(result : GameResult)
}

class ProcessWatcher: NSObject {
	var scoreLabel : UILabel!
	var mainLabel : UILabel!
	var translationLabel : UILabel!

	weak var delegate : GameProcessDelegate?

	private var mainTimer : NSTimer!
	private var score : Int = 0
	private var timeLeft = GameProcess.TimeForIteration

	func startGame(scoreLabel : UILabel, translationLabel : UILabel, mainLabel : UILabel){
		mainTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true)
	}

	func react(input : GameInput){

	}

	@objc private func incrementTime(){
		timeLeft -= 1
		if timeLeft == 0 {
			decrementScore()
		}
		delegate?.timePassed(timeLeft)
	}

	private func endGame(result : GameResult){
		delegate?.gameFinished(result)
		mainTimer.invalidate()
	}

	private func incrementScore(){
		score += GameProcess.PointsForIteration

		if score >= GameProcess.MaxPoints {
			endGame(GameResult.Win)
			return
		}

		restartIteration()
	}

	private func decrementScore(){
		score -= GameProcess.PointsForIteration

		if score <= GameProcess.MinPoints {
			endGame(GameResult.Lose)
			return
		}

		restartIteration()
	}

	private func restartIteration(){

	}
}
