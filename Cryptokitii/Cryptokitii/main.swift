import Foundation
import CryptoSwift

var pw: String?

func wlwl() {
    pw = "아니 이게 뭐야!"
    guard let data = pw?.sha256() else { return }
    print(data)
}
wlwl()

class AES256Util {
    //키값 32바이트: AES256(24bytes: AES192, 16bytes: AES128)
    private static let SECRET_KEY = "01234567890123450123456789012345"
    private static let IV = "0123456789012345"
 
    static func encrypt(string: String) -> String {
        guard !string.isEmpty else { return "" }
        return try! getAESObject().encrypt(string.bytes).toBase64()
    }
 
    static func decrypt(encoded: String) -> String {
        let datas = Data(base64Encoded: encoded)
 
        guard datas != nil else {
            return ""
        }
 
        let bytes = datas!.bytes
        let decode = try! getAESObject().decrypt(bytes)
 
        return String(bytes: decode, encoding: .utf8) ?? ""
    }
 
    private static func getAESObject() -> AES{
        let keyDecodes : Array<UInt8> = Array(SECRET_KEY.utf8)
        let ivDecodes : Array<UInt8> = Array(IV.utf8)
        let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs7)
 
        return aesObject
    }
}

print("냠냠".encrypt)
print(AES256Util.encrypt(string: "아악"))

import Foundation
import CryptoSwift

enum CBCEncryptorError: Error {
    case cannotLoadRawData
    case cannotLoadKeyBytes
    case cannotLoadIVBytes
    case encryptionFailed
}

protocol CBCEncryptor {
    var encryptedData: Data? { get }
    
    func encrypt(plainText: String, key: String, iv: String) throws -> String
}

final class DefaultCBCEncryptor: CBCEncryptor {
    
    private(set) var encryptedData: Data?
    
    init() {
        self.encryptedData = nil
    }
    
    func encrypt(plainText: String, key: String, iv: String) throws -> String {
        do {
            let data = try loadData(from: plainText)
            let keyData = try generateSymmetricKey(from: key)
            let ivData = try generateIV(from: iv)
            let aes = try createAES(key: keyData, iv: ivData)
            let encryptedData = try aes.encrypt(data.bytes)
            self.encryptedData = Data(encryptedData)
            return Data(encryptedData).base64EncodedString()
        } catch let error {
            throw error
        }
    }
    
    private func loadData(from string: String) throws -> Data {
        guard let data = string.data(using: .utf8) else { throw CBCEncryptorError.cannotLoadRawData }
        return data
    }
    
    private func generateSymmetricKey(from string: String) throws -> Data {
        let keyData = string.data(using: .utf8)
        guard let keyBytes = keyData?.bytes else { throw CBCEncryptorError.cannotLoadKeyBytes }
        let paddedKey = addPadding(keyBytes, size: 32, paddingByte: 0)
        
        return Data(paddedKey)
    }
    
    private func generateIV(from string: String) throws -> Data {
        let ivData = string.data(using: .utf8)
        guard let ivBytes = ivData?.bytes else { throw CBCEncryptorError.cannotLoadIVBytes }
        let paddedIV = addPadding(ivBytes, size: 16, paddingByte: 0)
        
        return Data(paddedIV)
    }
    
    private func createAES(key: Data, iv: Data) throws -> CryptoSwift.AES {
        return try AES(key: key.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7)
    }
    
    private func addPadding(_ array: [UInt8], size: Int, paddingByte: UInt8) -> [UInt8] {
        var paddedArray = array
        
        if paddedArray.count < size {
            let paddingCount = size - paddedArray.count
            let paddingBytes = Array(repeating: paddingByte, count: paddingCount)
            paddedArray.append(contentsOf: paddingBytes)
        }
        
        return paddedArray
    }
}

// String extension to use the DefaultCBCEncryptor
extension String {
    func encryptCBC(key: String, iv: String) throws -> String {
        let encryptor = DefaultCBCEncryptor()
        return try encryptor.encrypt(plainText: self, key: key, iv: iv)
    }
}

let plainText = "Hello, this is a test string."
    let key = "Cera"
    let iv = "BangBus"
    
    let encryptedText = try plainText.encryptCBC(key: key, iv: iv)
    print("Encrypted Text: \(encryptedText)")
