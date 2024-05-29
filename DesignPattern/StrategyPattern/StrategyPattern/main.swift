import Foundation

protocol Strategy {
    func execute()
}

class StudentRoute: Strategy {
    func execute() {
        print("학생입니다.")
    }
}

class TeacherRoute: Strategy {
    func execute() {
        print("선생님입니다.")
    }
}

class School {
    private var routeAlgorithm: Strategy?

    func execute() {
        self.routeAlgorithm?.execute()
    }

    func setStrategy(strategy: Strategy) {
        self.routeAlgorithm = strategy
    }
}

let school = School()
school.setStrategy(strategy: StudentRoute())
school.execute()

school.setStrategy(strategy: TeacherRoute())
school.execute()
