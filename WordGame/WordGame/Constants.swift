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
}

enum GameInput {
	case Yes
	case No
}