//
//  ProcessWatcher.swift
//  WordGame
//
//  Created by Сергей Грищёв on 12.08.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import AudioToolbox

protocol GameProcessDelegate : NSObjectProtocol{
	func timePassed(timeLeft: Float)
	func gameFinished(result : GameResult)
}

class ProcessWatcher: NSObject {
	weak var delegate : GameProcessDelegate?

	private var scoreLabel : UILabel!
	private var mainLabel : UILabel!
	private var translationLabel : UILabel!

	private var mainTimer : NSTimer!
	private var score : Int = 0
	private var timeLeft = GameProcess.TimeForIteration
	private var currentWord = (en: "", es: "")
	private var currentTranslation = (en: "", es: "")

	//MARK: Public methods 
	func startGame(lblScore : UILabel, lblTranslation : UILabel, lblMain : UILabel){
		scoreLabel = lblScore
		translationLabel = lblTranslation
		mainLabel = lblMain
		mainTimer = NSTimer.scheduledTimerWithTimeInterval(GameProcess.RefreshFrequency, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true)
		restartIteration()
	}

	func react(input : GameInput){
		vibrate()
		let isCorrectTranslation : Bool = (currentWord.es == currentTranslation.es)

		if input == .Yes {
			if isCorrectTranslation == true {
				incrementScore()
				return
			}
		}else{
			if isCorrectTranslation == false {
				incrementScore()
				return
			}
		}

		decrementScore()
	}

	@objc private func incrementTime(){
		timeLeft -= 1
		if timeLeft == 0 {
			decrementScore()
		}
		delegate?.timePassed(timeLeft)
	}

	//MARK: Increments & decrements
	private func endGame(result : GameResult){
		vibrate()
		delegate?.gameFinished(result)
		mainTimer.invalidate()
	}

	private func incrementScore(){
		score += GameProcess.PointsForIteration

		if score == GameProcess.MaxPoints {
			endGame(GameResult.Win)
			return
		}

		restartIteration()
	}

	private func decrementScore(){
		score -= GameProcess.PointsForIteration

		if score == GameProcess.MinPoints {
			endGame(GameResult.Lose)
			return
		}

		restartIteration()
	}

	//MARK: Iteration managment
	private func restartIteration(){
		timeLeft = GameProcess.TimeForIteration
		scoreLabel.text = "\(score)"
		mainLabel.text = targetWord()
		translationLabel.text = translationWord()
	}

	//MARK: Word managment
	private func targetWord() -> String{
		if let fullList = WordListWorker.fullList{
			let randomDic : NSDictionary = fullList.objectAtIndex(Int.random(0, upper: (fullList.count - 1))) as! NSDictionary
			currentWord.en = randomDic.objectForKey(WordList.EnText) as! String
			currentWord.es = randomDic.objectForKey(WordList.EsText) as! String
			return currentWord.en.firstLetterUppercase
		}

		//Something went terribly wrong, ending game with error ;(
		endGame(GameResult.Error)
		return ""
	}

	private func translationWord() -> String{
		if let fullList = WordListWorker.fullList{
			let randomDic : NSDictionary = fullList.objectAtIndex(Int.random(0, upper: (fullList.count - 1))) as! NSDictionary
			currentTranslation.en = randomDic.objectForKey(WordList.EnText) as! String
			currentTranslation.es = randomDic.objectForKey(WordList.EsText) as! String

			if Int.random(0, upper: 100) % 2 == 0{
				currentTranslation.es = currentWord.es
			}

			return currentTranslation.es.firstLetterUppercase
		}
		return ""
	}

	//MARK: Feedback

	private func vibrate(){
		AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
	}
}