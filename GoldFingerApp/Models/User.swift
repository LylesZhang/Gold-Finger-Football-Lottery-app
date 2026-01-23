import Foundation

struct User: Codable, Identifiable {
    let uid: Int
    let username: String
    let email: String?
    let password: String?
    let regip: String?
    let regdate: Int?
    let salt: String?
    
    // Identifiable协议要求
    var id: Int { uid }
    
    init(uid: Int, username: String,
         email: String? = nil, password: String? = nil, regip: String? = nil, regdate: Int? = nil, salt: String? = nil) {
            self.uid = uid
            self.username = username
            self.password = password
            self.email = email
            self.regip = regip
            self.regdate = regdate
            self.salt = salt
        }
}
