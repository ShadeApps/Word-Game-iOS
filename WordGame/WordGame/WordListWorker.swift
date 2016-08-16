//
//  WordListWorker.swift
//  WordGame
//
//  Created by Сергей Грищёв on 13.08.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

class WordListWorker: NSObject{

	static var fullList : NSArray?{
		get {
			let pathString : NSURL? = NSBundle.mainBundle().URLForResource(WordList.FileName, withExtension: WordList.FileExtension)

			if pathString != nil {
				let data = NSData.init(contentsOfURL: NSURL.init(string: pathString!.absoluteString)!)

				do{
					let MyData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
					return MyData
				}
				catch let error as NSError{
					print(error.description)
					return nil
				}
			}

			return nil
		}
	}
}
