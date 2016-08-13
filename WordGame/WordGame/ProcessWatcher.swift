//
//  ProcessWatcher.swift
//  WordGame
//
//  Created by Сергей Грищёв on 12.08.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

protocol GameProcessDelegate{
	func timePassed(timeLeft: Float)
	func gameFinished(result : GameResult)
}

class ProcessWatcher: NSObject {
	var scoreLabel : UILabel!
	var mainLabel : UILabel!
	var translationLabel : UILabel!

	private var mainTimer : NSTimer!
	private var score : Int!

	func startGame(scoreLabel : UILabel, translationLabel : UILabel, mainLabel : UILabel){
		mainTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true)
	}

	func react(input : GameInput){

	}

	@objc private func incrementTime(){

	}

	private func endGame(result : GameResult){

	}
}
