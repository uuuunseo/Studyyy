import Foundation

protocol Maratang: CustomStringConvertible {
    func cost() -> Int
}

protocol Decorating: Maratang {
    var maratang: Maratang { get set }
}

class ChinaGlassNoodle: Decorating {
    var maratang: Maratang
    var description: String {
        return self.maratang.description + "에 중국당면 추가"
    }

    init(maratang: Maratang) {
        self.maratang = maratang
    }

    func cost() -> Int {
        return self.maratang.cost() + 2000
    }
}

class Lamb: Decorating {
    var maratang: Maratang
    var description: String {
        return self.maratang.description + "에 양고기 추가"
    }

    init(maratang: Maratang) {
        self.maratang = maratang
    }

    func cost() -> Int {
        return self.maratang.cost() + 3000
    }
}

class BasicMaratang: Maratang {
    var description: String {
        return "기본 마라탕"
    }

    func cost() -> Int {
        return 7000
    }
}

let allMaratang = Lamb(maratang: ChinaGlassNoodle(maratang: BasicMaratang()))
let lambMaratang = Lamb(maratang: BasicMaratang())
let chinaGlassNoodleMaratang = ChinaGlassNoodle(maratang: BasicMaratang())

print("\(allMaratang.description) 가격은 \(allMaratang.cost())원")
print("\(lambMaratang.description) 가격은 \(lambMaratang.cost())원")
print("\(chinaGlassNoodleMaratang) 가격은 \(chinaGlassNoodleMaratang.cost())원")
