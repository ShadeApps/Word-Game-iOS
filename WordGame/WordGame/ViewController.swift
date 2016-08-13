//
//  ViewController.swift
//  WordGame
//
//  Created by Сергей Грищёв on 10.08.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var lblScore: UILabel!
	@IBOutlet weak var lblPossibleTranslation: UILabel!
	@IBOutlet weak var lblTargetWord: UILabel!
	@IBOutlet weak var topWordConstraint: NSLayoutConstraint!

	var processWatcher = ProcessWatcher()

	override func prefersStatusBarHidden() -> Bool {
		return true
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		processWatcher.startGame(lblScore, translationLabel: lblPossibleTranslation, mainLabel: lblTargetWord)
	}

	@IBAction func btnYesTapped(sender: AnyObject) {
		processWatcher.react(GameInput.Yes)
	}

	@IBAction func btnNoTapped(sender: AnyObject) {
		processWatcher.react(GameInput.No)
	}
}