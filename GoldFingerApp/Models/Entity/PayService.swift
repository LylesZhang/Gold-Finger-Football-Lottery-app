import Foundation

struct PayService: Codable, Identifiable, Equatable {
    let psId: Int
    let uid: Int
    let psServid: Int
    let psMoney: Double
    let begindate: String
    let enddate: String

    // 从 PayConfig 获取的服务详情
    let serviceName: String?
    let serviceIntro: String?
    let serviceTimeType: Int?
    let serviceTimeTypeName: String?
    let serviceEnabled: Bool?
    let serviceSmsEnabled: Bool?

    // Identifiable协议要求
    var id: Int { psId }
}
