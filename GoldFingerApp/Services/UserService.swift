import Foundation

class UserService{
    static let shares = UserService()
    private init(){}
    
    func validateCaptcha(captchaId: String, captchaCode: String) async throws {
        guard let url = URL(string: "http://localhost:8080/api/auth/login") else {
            throw APIError(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "captchaId=\(captchaId)&captchaCode=\(captchaCode)"
        request.httpBody = body.data(using: .utf8)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(LoginResponse.self, from: data)
        if !response.success {
            throw APIError(message: response.message ?? "验证码错误")
        }
    }
    
    func registerWithRemote(username: String, password: String) async throws {
        var components = URLComponents(string: "https://www.maicai.cn/u/")!
        components.queryItems = [
            URLQueryItem(name: "mod",      value: "myajax"),
            URLQueryItem(name: "file",     value: "myajax"),
            URLQueryItem(name: "action",   value: "NewMbReg"),
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "userpass", value: password),
        ]
        guard let url = components.url else { throw APIError(message: "Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(RemoteRegisterResponse.self, from: data)
        guard response.status == 1 else {
            throw APIError(message: response.msg ?? "注册失败")
        }
    }
    
    func getRealtimeBalance(username: String) async throws -> Double {
        var components = URLComponents(string: "https://www.maicai.cn/u/")!
        components.queryItems = [
            URLQueryItem(name: "mod",    value: "myajax"),
            URLQueryItem(name: "file",   value: "myajax"),
            URLQueryItem(name: "action", value: "get_newmb_smoney"),
            URLQueryItem(name: "uname",  value: username),
        ]
        guard let url = components.url else { throw APIError(message: "Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(SMoneyResponse.self, from: data)
        return Double(response.s_money ?? "0") ?? 0.0
    }

    func getAllPayServices(uid: Int) async throws -> PayServiceResponse{
        guard let url = URL(string: "http://localhost:8080/api/payuser/payservice?uid=\(uid)") else{
            throw APIError(message: "Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, urlResponse) = try await URLSession.shared.data(for: request)

        let response = try JSONDecoder().decode(PayServiceResponse.self, from: data)

        if response.success{
            return  response
        } else{
            throw APIError(message: response.message ?? "服务不存在")
        }
    }
    
    func getCaptcha() async throws -> CaptchaResponse{
        guard let url = URL(string: "http://localhost:8080/api/auth/captcha") else{
            throw APIError(message: "Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, urlResponse) = try await URLSession.shared.data(for: request)

        let response = try JSONDecoder().decode(CaptchaResponse.self, from: data)

        if response.success{
            return  response
        } else{
            throw APIError(message: response.message ?? "验证码创建失败")
        }
    }
    
    func subscribeService(uid: Int, psServid: Int, timeType: Int) async throws {
        guard let url = URL(string: "http://localhost:8080/api/service/subscribe?uid=\(uid)&ps_servid=\(psServid)&timeType=\(timeType)") else {
            throw APIError(message: "Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let (data, _) = try await URLSession.shared.data(for: request)

        let response = try JSONDecoder().decode(SubscribeResponse.self, from: data)

        if !response.success {
            throw APIError(message: response.message ?? "订阅失败")
        }
    }

    func getExperts() async throws -> [Expert] {
        guard let url = URL(string: "https://www.maicai.cn/newportal.php?type=indextj") else {
            throw APIError(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Expert].self, from: data)
    }

    func getBanners() async throws -> [Announcement] {
        guard let url = URL(string: "https://www.maicai.cn/newportal.php?type=appad") else {
            throw APIError(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Announcement].self, from: data)
    }

    func getDailyArticles(page: Int = 1) async throws -> [DailyArticle] {
        guard let url = URL(string: "https://www.maicai.cn/newportal_mc.php?type=gold&tid=0&page=\(page)") else {
            throw APIError(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([DailyArticle].self, from: data)
    }

    func getOnDemandArticles(newsId: Int) async throws -> [OnDemandArticle] {
        guard let url = URL(string: "https://www.maicai.cn/newportal.php?type=getlm&columnId=\(newsId)") else {
            throw APIError(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([OnDemandArticle].self, from: data)
    }

    // 远程登录：调用 checkNewMbLogin，返回包含 uid + jmck 的 User
    func loginWithRemote(username: String, password: String) async throws -> User {
        var components = URLComponents(string: "https://www.maicai.cn/u/")!
        components.queryItems = [
            URLQueryItem(name: "mod",      value: "myajax"),
            URLQueryItem(name: "file",     value: "myajax"),
            URLQueryItem(name: "action",   value: "checkNewMbLogin"),
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "userpass", value: password),
        ]
        guard let url = components.url else {
            throw APIError(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(RemoteLoginResponse.self, from: data)
        guard response.code == 0,
              let uid = response.uid,
              let jmck = response.jmck, !jmck.isEmpty else {
            throw APIError(message: response.message ?? "登录失败")
        }
        return User(uid: uid, username: response.user_name ?? username, jmck: jmck,
                    gfEnddate: response.gf_enddate,
                    cpznEnddate: response.cpzn_enddate,
                    jcrbEnddate: response.jcrb_enddate)
    }

    // 获取金手指日报文章详情
    func getDailyArticleDetail(fid: String, jmck: String) async throws -> ArticleDetailResponse {
        var components = URLComponents(string: "https://www.maicai.cn/u/")!
        components.queryItems = [
            URLQueryItem(name: "mod",    value: "myajax"),
            URLQueryItem(name: "file",   value: "myajax"),
            URLQueryItem(name: "action", value: "getGdNewsInfo2"),
            URLQueryItem(name: "fid",    value: fid),
            URLQueryItem(name: "ck",     value: jmck),
        ]
        guard let url = components.url else {
            throw APIError(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(ArticleDetailResponse.self, from: data)
    }

    // 获取文章详情 HTML 内容
    func getArticleDetail(fid: String, jmck: String) async throws -> ArticleDetailResponse {
        var components = URLComponents(string: "https://www.maicai.cn/u/")!
        components.queryItems = [
            URLQueryItem(name: "mod",    value: "myajax"),
            URLQueryItem(name: "file",   value: "myajax"),
            URLQueryItem(name: "action", value: "new_getnews"),
            URLQueryItem(name: "fid",    value: fid),
            URLQueryItem(name: "ck",     value: jmck),
        ]
        guard let url = components.url else {
            throw APIError(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(ArticleDetailResponse.self, from: data)
    }

    func getNewMbOrders(username: String, jmck: String) async throws -> [MbOrder] {
        var components = URLComponents(string: "https://www.maicai.cn/u/")!
        components.queryItems = [
            URLQueryItem(name: "mod",    value: "myajax"),
            URLQueryItem(name: "file",   value: "myajax"),
            URLQueryItem(name: "action", value: "getNewMbOrders"),
            URLQueryItem(name: "uname",  value: username),
            URLQueryItem(name: "ck",     value: jmck),
        ]
        guard let url = components.url else { throw APIError(message: "Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([MbOrder].self, from: data)
    }

    func getAllServiceGroups() async throws -> ServiceGroupResponse {
        guard let url = URL(string: "http://localhost:8080/api/service/groups") else {
            throw APIError(message: "Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)

        let response = try JSONDecoder().decode(ServiceGroupResponse.self, from: data)

        if response.success {
            return response
        } else {
            throw APIError(message: response.message ?? "服务分组拉取失败")
        }
    }

}
