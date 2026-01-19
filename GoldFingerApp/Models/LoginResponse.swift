import Foundation

struct LoginResponse: Codable {
    let success: Bool
    let uid: Int?
    let username: String?
    let email: String?
    let message: String?
}
