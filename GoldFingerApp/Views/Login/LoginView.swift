import SwiftUI

struct LoginView: View{
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View{
        VStack{
            Image("Login Background")
                .resizable()
                .frame(width:405, height:200)
                .padding(.top)
                .offset(y:-80)

            Spacer()
            
            
            VStack{
                Text("欢迎来到足坛金手指")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.yellow)
                TextField("用户名", text: $loginViewModel.username)
                    .textFieldStyle(.roundedBorder)
                SecureField("密码", text: $loginViewModel.password)
                    .textFieldStyle(.roundedBorder)
                if !loginViewModel.errorMessage.isEmpty{
                    Text(loginViewModel.errorMessage)
                        .foregroundStyle(.red)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 50)
            
            Button("登录"){
                loginViewModel.Login()
            }
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.cyan, lineWidth: 2)
            )
            
            Button("还没有账号？注册"){
                
            }
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.cyan, lineWidth: 2)
            )
            
            Spacer()
            
            Image("Login Background")
                .resizable()
                .frame(width:410, height:200)
                .padding(.bottom)
                .offset(y:105)
            
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
