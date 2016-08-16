//
//  MainViewController.swift
//  WordGame
//
//  Created by Сергей Грищёв on 10.08.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, GameProcessDelegate {
	@IBOutlet weak var lblScore: UILabel!
	@IBOutlet weak var lblPossibleTranslation: UILabel!
	@IBOutlet weak var lblTargetWord: UILabel!
	@IBOutlet weak var topWordConstraint: NSLayoutConstraint!

	var processWatcher = ProcessWatcher()

	//MARK: Lifecycle & Misc

	override func prefersStatusBarHidden() -> Bool {
		return true
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBarHidden = true
		processWatcher.delegate = self
		processWatcher.startGame(lblScore, lblTranslation: lblPossibleTranslation, lblMain: lblTargetWord)
	}

	//MARK: UI Actions

	@IBAction func btnYesTapped(sender: AnyObject) {
		processWatcher.react(GameInput.Yes)
	}

	@IBAction func btnNoTapped(sender: AnyObject) {
		processWatcher.react(GameInput.No)
	}

	//MARK: GameProcessDelegate

	func timePassed(timeLeft: Float){
		lblPossibleTranslation.alpha = CGFloat(timeLeft / GameProcess.TimeForIteration)

		var value = self.view.frame.height - CGFloat(Float(self.view.frame.height) * (timeLeft / GameProcess.TimeForIteration))

		if timeLeft == 0 {
			value = CGFloat(UI.TopConstantHeight)
		}

		UIView.animateWithDuration(UI.AnimationDuration, delay: 0, options: [.BeginFromCurrentState, .CurveEaseInOut] , animations: {
			self.topWordConstraint.constant = value
			}) { (true) in
				self.view.layoutIfNeeded()
		}
	}

	func gameFinished(result : GameResult){
		var message : String
		switch result {
		case .Win:
			message = UI.WinMessage
		case .Lose:
			message = UI.LoseMessage
		default:
			message = UI.GameStartErrorMessage
		}

		let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction.init(title: UI.CloseTitle, style: .Default){ (action) in
			self.navigationController?.popViewControllerAnimated(true)
		})
		self.presentViewController(alert, animated: true, completion: nil)
	}
}