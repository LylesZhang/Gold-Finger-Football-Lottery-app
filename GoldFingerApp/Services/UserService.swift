import Foundation

class UserService{
    static let shares = UserService()
    private init(){}
    
    func validLogin(username: String, password: String, captchaId: String, captchaCode: String) async throws -> User{
        guard let url = URL(string: "http://localhost:8080/api/auth/login") else{
            throw APIError(message: "Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let body = "idString=\(username)&password=\(password)&captchaId=\(captchaId)&captchaCode=\(captchaCode)"
        request.httpBody = body.data(using: .utf8)
        
        let (data, urlResponse) = try await URLSession.shared.data(for: request)

        let response = try JSONDecoder().decode(LoginResponse.self, from: data)

        if response.success, let uid = response.uid, let username = response.username{
            return User(uid: uid, username: username)
        } else{
            throw APIError(message: response.message ?? "登陆失败")
        }
    }
    
    func validRegister(username: String, password: String) async throws -> User{
        guard let url = URL(string: "http://localhost:8080/api/auth/register") else{
            throw APIError(message: "Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let body = "username=\(username)&password=\(password)"
        request.httpBody = body.data(using: .utf8)
        
        let (data, urlResponse) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(RegisterResponse.self, from: data)
        
        if response.success, let uid = response.uid, let username = response.username{
            return  User(uid: uid, username: username)
        } else{
            throw APIError(message: response.message ?? "注册失败")
        }
    }
    
    func getAccountinfo(username: String) async throws -> AccountInfoResponse{
        guard let url = URL(string: "http://localhost:8080/api/payuser/balance?username=\(username)") else{
            throw APIError(message: "Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, urlResponse) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(AccountInfoResponse.self, from: data)
        
        if response.success{
            return  response
        } else{
            throw APIError(message: response.message ?? "查找余额失败")
        }
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
