import Foundation

struct MbOrder: Codable, Identifiable {
    var id: String { "\(time ?? "")-\(money ?? "")-\(title ?? note_name ?? "")" }
    let type_name: String?
    let money: String?
    let balance: String?
    let time: String?
    let note_name: String?
    let title: String?
}
