import CryptoKit
import Foundation

let text = "냠냠"
print(text)

// Nomal Hashing
func hashItem(item: String) -> Int {
    var hasher = Hasher()
    item.hash(into: &hasher)
    return hasher.finalize()
}
print(hashItem(item: text))

// SHA
// 이미지 데이터 받아오기
func getData(for item: String, of type: String) -> Data {
    let filePath = Bundle.main.path(forResource: item, ofType: type)!
    return FileManager.default.contents(atPath: filePath)!
}

let data = getData(for: "Baby", of: "png")
let digest = SHA256.hash(data: data) // 256-bit의 digest를 만든다.

// 송신자는 'data'와 'digest'를 수신자에게 보낸다.
// 수신자는 'data'를 cryptographic hasing한 값과 'digest'를 비교한다. 같으면 데이터 무결성 검증 완료
let receivedDataDigest = SHA256.hash(data: data)
if digest == receivedDataDigest {
    print("보낸 data == 받은 data")
}
