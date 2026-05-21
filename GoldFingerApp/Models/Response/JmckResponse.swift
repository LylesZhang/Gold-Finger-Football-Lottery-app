import Foundation

struct JmckResponse: Codable {
    let code: Int?
    let jmck: String?
    let message: String?
}
