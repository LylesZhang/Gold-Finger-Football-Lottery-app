import Foundation

struct ServiceConfig: Codable, Identifiable, Equatable {
    let id: Int
    let name: String?
    let money: Int?
    let timeType: Int?
    let enabled: Bool?
    let smsEnabled: Bool?
    let intro: String?
    let user: String?
    let discount: Int?
}
