# libscrypt-swift
Swift wrapper for libscrypt library: https://github.com/technion/libscrypt. Happy slow-hashing.


## Usage

```swift

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

```
