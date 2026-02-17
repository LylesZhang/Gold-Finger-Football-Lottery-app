struct CaptchaResponse: Codable {
    let success: Bool
    let captchaId: String?
    let verifyCodeImage: String?  // Base64 图片字符串
    let message: String?
}
