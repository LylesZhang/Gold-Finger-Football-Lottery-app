import Foundation
import Combine

class RegisterViewModel: ObservableObject{
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoad: Bool = false
    @Published var registerMessage: String = ""
    
    func Register(){
        
        registerMessage = ""
        
        guard !username.isEmpty else{
            registerMessage = "请输入用户名"
            return
        }
        
        guard !password.isEmpty else{
            registerMessage = "请设置密码"
            return
        }
        
        isLoad = true
        
        Task{
            do{
                let user = try await UserService.shares.validLogin(username: username, password: password)
                await MainActor.run{
                    registerMessage = "登录成功！"
                    isLoad = false
                }
            }catch{
                await MainActor.run{
                    registerMessage = "密码或用户名不正确！"
                    isLoad = false
                }
            }
        }
    }
}
