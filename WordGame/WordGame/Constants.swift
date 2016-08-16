//
//  Constants.swift
//  WordGame
//
//  Created by Сергей Грищёв on 12.08.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import Foundation

struct UI {
	static let TopConstantHeight = 8
	static let WinMessage = "Congratulations! You won! 👾🏅"
	static let LoseMessage = "Oh no! You lost! 😩💔"
	static let GameStartErrorMessage = "Something went wrong and it's not your fault. We're sorry 😢😓"

	static let CloseTitle = "Close"
}

struct GameProcess {
	static let TimeForIteration : Float = 15.0

	static let PointsForIteration = 5

	static let MaxPoints = 50
	static let MinPoints = -50
}

enum GameResult {
	case Win
	case Lose
	case Error
}

enum GameInput {
	case Yes
	case No
}

struct WordList {

	static let FileName = "words"
	static let FileExtension = "json"

	static let EnText = "text_eng"
	static let EsText = "text_spa"
}

struct AppInfo {
	static let URL = "http://stackoverflow.com/users/1313939/sergiusgee?tab=profile"
}