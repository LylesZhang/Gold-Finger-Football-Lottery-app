import SwiftUI

struct RegisterView: View{
    @StateObject private var loginViewModel = LoginViewModel()
    @StateObject private var registerViewModel = RegisterViewModel()
    
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
                TextField("请输入用户名", text: $loginViewModel.username)
                    .textFieldStyle(.roundedBorder)
                SecureField("请输入密码", text: $loginViewModel.password)
                    .textFieldStyle(.roundedBorder)
                if !loginViewModel.loginMessage.isEmpty{
                    Text(loginViewModel.loginMessage)
                        .foregroundStyle(loginViewModel.loginMessage.contains("成功") ? .green : .red)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 50)
            
            Button("创建新用户"){
                registerViewModel.Register()
            }
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.cyan, lineWidth: 2)
            )
            
            Spacer()
            
            Image("Login Background")
                .resizable()
                .frame(width:405, height:200)
                .padding(.bottom)
                .offset(y:80)
            
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
