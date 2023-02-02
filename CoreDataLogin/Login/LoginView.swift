//
//  LoginView.swift
//  CoreDataLogin
//
//  Created by Guru Mahan on 01/02/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
  //  @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var todoItems: FetchedResults<Todo>
  
  
    @State var emailText:String = ""
    @State var passWordText:String = ""
    @State var isSuccess = false
    @State var moveToSignUpView = false
    @State var message = ""
    @State var showEmailValidationErrorLabel = false
    @State var showPasswordValidationText = false
    @State var showEmailFormat = false
    @State var showPasswordFormat = false
    @State var showEnterYourEmail = false
    @State var showEnterYourPassword = false
    @State var showDonotHaveAccount = false
     @StateObject var viewModel = LoginViewModel()
    var body: some View {
        
        NavigationView {
            
           
            ZStack {
               
                NavigationLink(isActive: $moveToSignUpView) {
                    SignUpView()
                } label: {
                    EmptyView()
                }
                NavigationLink(isActive: $isSuccess) {
                    DashboardView()
                } label: {
                    EmptyView()
                }
                //            Color.blue
                LinearGradient(colors: [Color(hex: "1A7BDC"), Color(hex: "56B8FF")], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                
                VStack {
                    
                    VStack {
                        HStack{
                            
                            Image(systemName: "globe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40,height: 50,alignment: .center)
                                .foregroundColor(Color.white)
                            
                            Text("DigiClass")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                        }
                        bodyView
                            .frame(maxWidth: .infinity,maxHeight: UIScreen.main.bounds.height / 2)
                            
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(5)
                        
                    }
                    Spacer()
                }
            }
        }.navigationBarBackButtonHidden(true)
    }

    @ViewBuilder var bodyView: some View{
        
        VStack(alignment:.center){
            Text("Login")
                .font(.system(size: 20))
                .padding()
            VStack(alignment:.leading){
                
                Text("Email")
                    .font(.system(.subheadline))
                //                    .padding(.leading,-13)
                VStack(alignment: .leading, spacing:0){
                    TextField("  Enter Email Id", text: $emailText)
                        .font(.system(.subheadline))
                        .frame(maxWidth: .infinity,maxHeight: 40,alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius:5)
                            .stroke(Color.gray,lineWidth: 2)
                        )
                        if showEmailValidationErrorLabel{
                           
                            Text("Invalid EMail")
                                .font(.system(size: 16))
                                .foregroundColor(.red)
                     }
                    if showEmailFormat{
                        displayAlertMessage(userMessage:"Invalid Format" )
                               .font(.system(size: 16))
                               .foregroundColor(.red)
                    }
                    if showEnterYourEmail{
                        displayAlertMessage(userMessage: "Enter Your Email" )
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                    }
                }
               
                Text(
                    "PassWord")
                .font(.system(.subheadline))
                //                .padding()
                .padding(2)
                VStack(alignment: .leading, spacing:0){
                    TextField("  Enter PassWord", text: $passWordText)
                        .font(.system(.subheadline))
                        .frame(maxWidth: .infinity,maxHeight: 40,alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius:5).stroke(Color.gray,lineWidth: 2))
                    
                    if showPasswordValidationText{
                       displayAlertMessage(userMessage:"Invalid Password" )
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                 }
                 if showPasswordFormat{
                     displayAlertMessage(userMessage:"Invalid Format" )
                            .font(.system(size: 16))
                            .foregroundColor(.red)
                 }
                    if showEnterYourPassword{
                        displayAlertMessage(userMessage: "Enter Your Password" )
                               .font(.system(size: 16))
                               .foregroundColor(.red)
                    }
                    
            }
        }
            .padding(10)
            
            Button {
                
         
              
              //  if !emailText.isEmpty && !passWordText.isEmpty{
                    check()
             //   }
            } label: {
                Text("Login")
                
                    .frame(width: 240,height:40)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(5)
                    .padding(.horizontal,40)
            }
         Divider()
            
            Button {
               moveToSignUpView = true
            } label: {
                Text("SignUp")
            }
            if showDonotHaveAccount{
                displayAlertMessage(userMessage:"Don't Have Account")
                    .frame(width: 240,height: 40)
                    .foregroundColor(.red)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    @ViewBuilder func displayAlertMessage(userMessage:String) -> some View{
           VStack{
               Text("\(userMessage)")
           }
       }
    
    func check(){
        
        if emailText.isEmpty{
            withAnimation {
                showEnterYourEmail = true
            }
        } else if !emailText.isEmpty{
            showEnterYourEmail = false
            if !viewModel.isValidEmail(testStr: emailText){
                withAnimation {
                    showEmailFormat = true
                   showEmailValidationErrorLabel = false
                  //  showEnterYourEmail = false
                }
 
            }else if viewModel.isValidEmail(testStr: emailText){
                withAnimation {
                    showEmailValidationErrorLabel = false
                    showEmailFormat = false
                }
                
                if todoItems.filter({$0.email == emailText}).isEmpty{
                    
                    withAnimation {
                        showDonotHaveAccount = true
                    }
                 
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        withAnimation {
                            showDonotHaveAccount = false
                        }
                       
                    }
               }
            }
        }

        
        if passWordText.isEmpty{
            withAnimation {
                showEnterYourPassword = true
              //  showEmailValidationErrorLabel = false
                showPasswordValidationText = false
                showPasswordFormat = false
            }
        }else if !passWordText.isEmpty{
            showEnterYourPassword = false
            if !viewModel.isPasswordValid(passWordText){

                withAnimation {
                    showPasswordValidationText = false
                    showEnterYourPassword = false
                    showPasswordFormat = true
                }
            }else if viewModel.isPasswordValid(passWordText){
                withAnimation {
                    //  showEmailValidationErrorLabel = false
                    showPasswordValidationText = false
                    showPasswordFormat = false
                }
                if  todoItems.filter({$0.passWord == passWordText}).isEmpty{
                  
                    withAnimation {
                        showDonotHaveAccount = true
                    }
                 
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        withAnimation {
                            showDonotHaveAccount = false
                        }
                    }
                    
            }else if let item = todoItems.filter({$0.email == emailText || $0.passWord == passWordText}).first{
                
                    if item.email == emailText
                        && item.passWord == passWordText{
                        isSuccess = true
                        UserDefaults.standard.set(true, forKey: "islogin")
                    }
                }
            }
            
        }
       
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
