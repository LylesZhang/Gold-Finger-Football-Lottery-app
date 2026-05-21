import Foundation

struct ArticleDetailResponse: Codable {
    let status: Int?
    let content: String?   // 文章HTML内容
    let title: String?
    let msg: String?
}
