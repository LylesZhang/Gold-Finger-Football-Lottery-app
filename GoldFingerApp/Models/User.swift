//
//  User.swift
//  GoldFingerApp
//
//  Created by Zero_Legend on 2026/1/17.
//

import Foundation

struct User: Codable, Identifiable {
    let uid: Int
    let username: String
    let password: String
    let email: String
    let regip: String?
    let regdate: Int?
    let salt: String?
    
    // Identifiable协议要求
    var id: Int { uid }
    
    // 编码键映射（如果需要从JSON解析）
    enum CodingKeys: String, CodingKey {
        case uid
        case username
        case password
        case email
        case regip
        case regdate
        case salt
    }
    
    init(uid: Int, username: String, password: String, email: String,
             regip: String? = nil, regdate: Int? = nil, salt: String? = nil) {
            self.uid = uid
            self.username = username
            self.password = password
            self.email = email
            self.regip = regip
            self.regdate = regdate
            self.salt = salt
        }
}
