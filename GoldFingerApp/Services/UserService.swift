import Foundation

class UserService{
    static let shares = UserService()
    private init(){}
    
    private let testUsers: [User] =
    [User(uid: 1, username: "zzy", password: "123", email: ""),
     User(uid: 2, username: "yzz", password: "234", email: ""),
     User(uid: 3, username: "zyz", password: "345", email: "")]
    
    func validLogin(username: String, password: String) -> User?{
        return testUsers.first{$0.username == username && $0.password == password}
    }
}
