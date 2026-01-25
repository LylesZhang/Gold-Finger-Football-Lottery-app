import SwiftUI

struct LoginView: View{
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isLogin = false
    
    var body: some View{
        NavigationStack{
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
                    if !loginViewModel.loginMessage.isEmpty{
                        Text(loginViewModel.loginMessage)
                            .foregroundStyle(loginViewModel.loginMessage.contains("成功") ? .green : .red)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 50)
                
                VStack{
                    Button("登录"){
                        Task{
                            await loginViewModel.Login()
                            if(loginViewModel.loginMessage.contains("成功")){
                                try? await Task.sleep(nanoseconds: 1_000_000_000)
                                isLogin = true
                            }
                        }
                    }
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                    
                    NavigationLink(destination: RegisterView()){
                        Text("还没有账号？注册")
                    }
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                }
                .navigationDestination(isPresented: $isLogin){
                    AccountView()
                }
                
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
}

#Preview {
    LoginView()
}
