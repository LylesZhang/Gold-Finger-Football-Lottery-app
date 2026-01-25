import Foundation
import Combine

class RegisterViewModel: ObservableObject{
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoad: Bool = false
    @Published var registerMessage: String = ""
    
    func Register() async {

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

        do{
            let user = try await UserService.shares.validRegister(username: username, password: password)
            await MainActor.run{ // 网络请求完成后，需要切换到主线程来更新 UI
                registerMessage = "注册成功！"
                isLoad = false
            }
        }catch{
            await MainActor.run{
                registerMessage = error.localizedDescription
                isLoad = false
            }
        }
    }
}
