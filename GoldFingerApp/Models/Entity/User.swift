import Foundation

struct User: Codable, Identifiable, Equatable {
    let uid: Int
    let username: String
    let email: String?
    let password: String?
    let regip: String?
    let regdate: Int?
    let salt: String?
    var jmck: String?         // maicai.cn 加密Cookie，用于获取文章详情
    var gfEnddate: String?    // 金手指日报订阅到期日
    var cpznEnddate: String?  // 彩票指南订阅到期日
    var jcrbEnddate: String?  // 竞彩日报订阅到期日

    // Identifiable协议要求
    var id: Int { uid }

    init(uid: Int, username: String,
         email: String? = nil, password: String? = nil, regip: String? = nil, regdate: Int? = nil, salt: String? = nil,
         jmck: String? = nil, gfEnddate: String? = nil, cpznEnddate: String? = nil, jcrbEnddate: String? = nil) {
            self.uid = uid
            self.username = username
            self.password = password
            self.email = email
            self.regip = regip
            self.regdate = regdate
            self.salt = salt
            self.jmck = jmck
            self.gfEnddate = gfEnddate
            self.cpznEnddate = cpznEnddate
            self.jcrbEnddate = jcrbEnddate
        }
}
