import Foundation

struct PayService: Codable, Identifiable, Equatable {
    let psId: Int
    let uid: Int
    let psServid: Int
    let psMoney: Double
    let begindate: String
    let enddate: String

    // Identifiable协议要求
    var id: Int { psId }
}
