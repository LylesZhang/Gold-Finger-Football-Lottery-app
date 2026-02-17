import SwiftUI

struct RegisterView: View{
    @StateObject private var registerViewModel = RegisterViewModel()
    @Environment(\.dismiss) private var dismiss
    
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
                TextField("请输入用户名", text: $registerViewModel.username)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                SecureField("请输入密码", text: $registerViewModel.password)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                if !registerViewModel.registerMessage.isEmpty{
                    Text(registerViewModel.registerMessage)
                        .foregroundStyle(registerViewModel.registerMessage.contains("成功") ? .green : .red)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 50)
            
            Button("创建新用户"){
                Task{
                    await registerViewModel.Register()
                    if registerViewModel.registerMessage.contains("成功"){
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                        dismiss()
                    }
                }
            }
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.cyan, lineWidth: 2)
            )
            
            Button("返回登录界面"){
                dismiss()
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
        .navigationBarHidden(true)
    }
}

#Preview {
    RegisterView()
}
