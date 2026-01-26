import Foundation

class UserService{
    static let shares = UserService()
    private init(){}
    
    func validLogin(username: String, password: String) async throws -> User{
        guard let url = URL(string: "http://localhost:8080/api/auth/login") else{
            throw APIError(message: "Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let body = "idString=\(username)&password=\(password)"
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
}
