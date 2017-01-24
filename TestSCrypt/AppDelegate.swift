//
//  AppDelegate.swift
//  TestSCrypt
//
//  Created by Matej Ukmar on 24/01/2017.
//  Copyright © 2017 ZEN+. All rights reserved.
//

import UIKit
import PlusSCrypt

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		let start = Date()
		
		let hash = SCrypt.gen(length: 32, password: "Mjskl12@$^xkmc", salt: "Abcdefghijklo", N: 2*SCrypt.N, r: SCrypt.r, p: SCrypt.p)
		
		let end = Date()
		
		let ti = end.timeIntervalSince(start)
		
		if let hash = hash {
			print("hashing took: \(ti) secs")
			
			print("raw hash: \([UInt8](hash))")
			
			print("hash: \(hash.base64EncodedString())")
		} else {
			print("hashing failed")
		}

		
		return true
	}


}

