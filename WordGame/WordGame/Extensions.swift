//
//  Extensions.swift
//  WordGame
//
//  Created by Сергей Грищёв on 16.08.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import Foundation

func arc4random <T: IntegerLiteralConvertible> (type: T.Type) -> T {
	var r: T = 0
	arc4random_buf(&r, sizeof(T))
	return r
}

extension UInt64 {
	static func random(lower: UInt64 = min, upper: UInt64 = max) -> UInt64 {
		var m: UInt64
		let u = upper - lower
		var r = arc4random(UInt64)

		if u > UInt64(Int64.max) {
			m = 1 + ~u
		} else {
			m = ((max - (u * 2)) + 1) % u
		}

		while r < m {
			r = arc4random(UInt64)
		}

		return (r % u) + lower
	}
}

extension Int64 {
	static func random(lower: Int64 = min, upper: Int64 = max) -> Int64 {
		let (s, overflow) = Int64.subtractWithOverflow(upper, lower)
		let u = overflow ? UInt64.max - UInt64(~s) : UInt64(s)
		let r = UInt64.random(upper: u)

		if r > UInt64(Int64.max)  {
			return Int64(r - (UInt64(~lower) + 1))
		} else {
			return Int64(r) + lower
		}
	}
}

extension UInt32 {
	static func random(lower: UInt32 = min, upper: UInt32 = max) -> UInt32 {
		return arc4random_uniform(upper - lower) + lower
	}
}

extension Int32 {
	static func random(lower: Int32 = min, upper: Int32 = max) -> Int32 {
		let r = arc4random_uniform(UInt32(Int64(upper) - Int64(lower)))
		return Int32(Int64(r) + Int64(lower))
	}
}

extension UInt {
	static func random(lower: UInt = min, upper: UInt = max) -> UInt {
		switch (__WORDSIZE) {
		case 32: return UInt(UInt32.random(UInt32(lower), upper: UInt32(upper)))
		case 64: return UInt(UInt64.random(UInt64(lower), upper: UInt64(upper)))
		default: return lower
		}
	}
}

extension Int {
	static func random(lower: Int = min, upper: Int = max) -> Int {
		switch (__WORDSIZE) {
		case 32: return Int(Int32.random(Int32(lower), upper: Int32(upper)))
		case 64: return Int(Int64.random(Int64(lower), upper: Int64(upper)))
		default: return lower
		}
	}
}

extension String {
	var first: String {
		return String(characters.prefix(1))
	}
	var last: String {
		return String(characters.suffix(1))
	}
	var firstLetterUppercase: String {
		return first.uppercaseString + String(characters.dropFirst())
	}
}