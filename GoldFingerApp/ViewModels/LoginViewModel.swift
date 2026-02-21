import Foundation
import Combine
import UIKit

class LoginViewModel: ObservableObject{
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoad: Bool = false
    @Published var loginMessage: String = ""
    @Published var loginUser: User? = nil
    
    @Published var captchaId: String = ""
    @Published var captchaCode: String = ""       // 用户输入的验证码
    @Published var captchaImage: UIImage? = nil    // 显示的验证码图片
    
    func Login() async{
        
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
            let user = try await UserService.shares.validLogin(username: username, password: password, captchaId: captchaId, captchaCode: captchaCode)
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
            await loadCapta()
        }
    }
    
    func loadCapta() async{
        do{
            let response = try await UserService.shares.getCaptcha()
            await MainActor.run{
                captchaId = response.captchaId ?? ""
                if let base64Str = response.verifyCodeImage,let data = Data(base64Encoded: base64Str) {
                    captchaImage = UIImage(data: data)
                }
            }
        } catch{
            await MainActor.run{
                loginMessage = error.localizedDescription
                isLoad = false
            }
        }
    }
}
