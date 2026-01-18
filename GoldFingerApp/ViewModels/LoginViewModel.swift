import Foundation
import Combine

class LoginViewModel: ObservableObject{
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoad: Bool = false
    @Published var errorMessage: String = ""
    
    func Login(){
        
        errorMessage = ""
        
        guard !username.isEmpty else{
            errorMessage = "请输入用户名"
            return
        }
        
        guard !password.isEmpty else{
            errorMessage = "请输入密码"
            return
        }
        
        isLoad = true
        
        if let user = UserService.shares.validLogin(username: username, password: password){
            print("登陆成功！")
        }
        else{
            errorMessage = "账号或密码错误！"
        }
        
        isLoad = false
    }
}
