import CryptoKit
import Foundation

func getData(for item: String, of type: String) -> Data {
    let filePath = Bundle.main.path(forResource: item, ofType: type)!
    return FileManager.default.contents(atPath: filePath)!
}

// HMAC
let data = getData(for: "Baby", of: "png")

let key256 = SymmetricKey(size: .bits256)

let sha512MAC = HMAC<SHA512>.authenticationCode(for: data, using: key256)

let authenticationData = Data(sha512MAC)

if HMAC<SHA512>.isValidAuthenticationCode(authenticationData, authenticating: data, using: key256) {
    print(data)
} else {
    print("not valid")
}
