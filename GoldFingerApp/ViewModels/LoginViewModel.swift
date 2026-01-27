import Foundation
import Combine

class LoginViewModel: ObservableObject{
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoad: Bool = false
    @Published var loginMessage: String = ""
    @Published var loginUser: User? = nil
    
    func Login() async{
        
        loginMessage = ""
        
        guard !username.isEmpty else{
            loginMessage = "请输入用户名"
            return
        }
        
        guard !password.isEmpty else{
            loginMessage = "请输入密码"
            return
        }
        
        isLoad = true
        
        do{
            let user = try await UserService.shares.validLogin(username: username, password: password)
            await MainActor.run{
                loginMessage = "登录成功！"
                loginUser = user
                isLoad = false
            }
        }catch{
            await MainActor.run{
                loginMessage = error.localizedDescription
                isLoad = false
            }
        }
    }
}
