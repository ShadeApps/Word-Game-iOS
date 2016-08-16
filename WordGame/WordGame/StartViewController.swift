//
//  StartViewController.swift
//  WordGame
//
//  Created by Сергей Грищёв on 16.08.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

	override func prefersStatusBarHidden() -> Bool {
		return true
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBarHidden = true
	}

	@IBAction func btnInfoTapped(sender: AnyObject) {
		UIApplication.sharedApplication().openURL(NSURL.init(string: AppInfo.URL)!)
	}
}
