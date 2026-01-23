import Foundation

struct RegisterResponse: Codable {
    let success: Bool
    let uid: Int?
    let username: String?
    let message: String?
}
