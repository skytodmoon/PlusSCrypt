//
//  Crypto.swift
//  SwiftScrypt
//
//  Created by Matej Ukmar on 21/01/2017.
//  Copyright © 2017 ZEN+. All rights reserved.
//

import Foundation



public class SCrypt {
	
	public enum Error : Swift.ErrorType {
		case gen
	}
	
	public static let p: UInt32 = 1
	public static let r: UInt32 = 8
	public static let N: UInt64 = 16384
	
	/**
	
	Generates scrypt hash.
	
	- Parameter length: Length of the resulting hash
	- Parameter password: Password data bytes
	- Parameter salt: Salt data bytes
	- Parameter N: CPU & RAM cost - main performance modifier
	- Parameter r: RAM cost
	- Parameter p: CPU cost
	
	- Returns: Scrypt hash data with `length` bytes or nil on error
	
	N is main performance modifier. Values for r = 8 and p = 1 are standard. Can be modified for custom CPU/RAM ratio. The parameters r, p are limited by r * p < 2^30 and length <= (2^32 - 1) * 32. The parameter N must be a power of 2 greater than 1.
	
	*/
	
	public class func gen(length: Int, password: Data, salt: Data, N: UInt64, r: UInt32, p: UInt32) -> Data? {
		
		let passwordUnsafeBytesPointer = password.withUnsafeBytes { (unsafePointer) -> UnsafePointer<UInt8> in
			return unsafePointer
		}
		
		let saltUnsafeBytesPointer = salt.withUnsafeBytes { (unsafePointer) -> UnsafePointer<UInt8> in
			return unsafePointer
		}
		
		var hash = [UInt8](repeating: 0, count: length)
		
		let result = libscrypt_scrypt(passwordUnsafeBytesPointer, password.count, saltUnsafeBytesPointer, salt.count, N, r, p, &hash, hash.count)
		
		guard result == 0 else {
			return nil
		}
		
		return Data(bytes: hash)

	}

	public class func gen(length: Int, password: String, salt: String, N: UInt64, r: UInt32, p: UInt32) -> Data? {
		let passwordData = password.data(using: .utf8)!
		let saltData = salt.data(using: .utf8)!
		return gen(length: length, password: passwordData, salt: saltData, N: N, r: r, p: p)
	}

	
	
}

