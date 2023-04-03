//
//  ContentView.swift
//  CoreDataLogin
//
//  Created by Guru Mahan on 01/02/23.
//

import SwiftUI
import CoreData

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var todoItems: FetchedResults<Todo>
    @State var emailText:String = ""
    @State var passWordText:String = ""
    @State var confirmPassWordText:String = ""
    @State var isTappedToGo = false
    @State var showEmailFormat = false
    @State var showPasswordFormat = false
    @State var showEnterYourEmail = false
    @State var showEnterYourPassword = false
    @State var showEnterConfirmPassword = false
    @State var showEnterConfirmPasswordFormat = false
    @State var showPasswordDonotMatch = false
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(hex: "1A7BDC").opacity(0.85), Color(hex: "56B8FF").opacity(0.85)], startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
            VStack {
                HStack{
                    Image("digiClassIconWhite")
                    Text("DigiClass")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                bodyView
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color(hex: "111827").opacity(0.4),
                            radius: 2, x: 1, y: 1)
                    .padding(15)
            }
        }
    }
    
    @ViewBuilder var bodyView: some View{
        VStack{
            Text("Sign Up")
                .foregroundColor(Color(hex: "666666"))
                .font(Font.custom("Roboto-Medium", size: 18))
                .padding()
            textFieldPanel
            ZStack{
                Button {
                    check()
                } label: {
                    Text("Sing Up")
                        .font(Font.custom("Roboto-Medium", size: 16))
                        .foregroundColor(Color.white)
                        .frame(width: 296, height: 40)
                        .padding([.trailing,.leading], 16.0)
                        .background(Color(hex: "147AFC"))
                        .cornerRadius(4)
                }
                if showPasswordDonotMatch{
                    displayAlertMessage(userMessage: "Password Don't Match")
                        .font(Font.custom("Roboto-Medium", size: 16))
                        .foregroundColor(.red)
                        .frame(width: 296, height: 40)
                        .padding([.trailing,.leading], 16.0)
                        .background(Color.white)
                        .cornerRadius(4)
                }
            }
            Divider().padding()
            Text("Already have an account?")
                .padding(2)
            Button {
                if presentationMode.wrappedValue.isPresented {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Login")
            }.padding()
            
        }
    }
    
    @ViewBuilder var textFieldPanel: some View {
        VStack(alignment:.leading,spacing: 0){
            VStack(alignment: .leading){
                Text("Email")
                    .foregroundColor(Color(hex: "6B7280"))
                    .font(Font.custom("Roboto-Regular", size: 14))
                
                TextField("Enter Email Id", text: $emailText)
                    .autocapitalization(.none)
                    .clearTextFieldText(text: $emailText)
                    .font(Font.custom("Roboto-Regular", size: 16))
                    .padding()
                    .frame(height: 48)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color(hex: "D1D5DB")))
                EmailErrorMessage
            }.padding()
            VStack(alignment: .leading) {
                Text(
                    "PassWord")
                .foregroundColor(Color(hex: "6B7280"))
                .font(Font.custom("Roboto-Regular", size: 14))
                PasswordField(password: $passWordText)
                PasswordErrorMessage
            } .padding()
            VStack(alignment: .leading){
                Text(
                    "Confirm PassWord")
                .foregroundColor(Color(hex: "6B7280"))
                .font(Font.custom("Roboto-Regular", size: 14))
                TextField("Enter ConfirmPassWord", text: $confirmPassWordText)
                    .autocapitalization(.none)
                    .clearTextFieldText(text: $emailText)
                    .font(Font.custom("Roboto-Regular", size: 16))
                    .padding()
                    .frame(height: 48)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color(hex: "D1D5DB")))
                confirmPasswordErrorMessage
            }.padding()
        }
    }
    
    @ViewBuilder var EmailErrorMessage: some View {
        if showEmailFormat{
            displayAlertMessage(userMessage:"Invalid Format" )
        }
        if showEnterYourEmail{
            displayAlertMessage(userMessage: "Enter  Email" )
        }
    }
    
    @ViewBuilder var PasswordErrorMessage: some View {
        if showPasswordFormat{
            displayAlertMessage(userMessage:"Invalid Format" )
        }
        if showEnterYourPassword{
            displayAlertMessage(userMessage: "Enter Password" )
        }
    }
    
    @ViewBuilder var confirmPasswordErrorMessage: some View {
        if showEnterConfirmPasswordFormat{
            displayAlertMessage(userMessage:"Invalid Format" )
        }
        if showEnterConfirmPassword{
            displayAlertMessage(userMessage: "Enter confirmPassword" )
        }
    }
    
    @ViewBuilder func displayAlertMessage(userMessage:String) -> some View{
        VStack{
            Text("\(userMessage)")
                .foregroundColor(Color(UIColor.red.withAlphaComponent(0.75)))
                .font(Font.custom("Roboto-Regular", size: 14))
        }
    }
    
    private func addItem() {
        let newTask = Todo(context: viewContext)
        newTask.email = emailText
        newTask.passWord = passWordText
        newTask.confirmPassword = confirmPassWordText
        do{
            try viewContext.save()
        }catch{
            print("Can't Saved")
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
                }
            }else if viewModel.isValidEmail(testStr: emailText){
                withAnimation {
                    showEmailFormat = false
                }
            }
        }
        if passWordText.isEmpty{
            withAnimation {
                showEnterYourPassword = true
                showPasswordFormat = false
            }
        }else if !passWordText.isEmpty{
            showEnterYourPassword = false
            if !viewModel.isPasswordValid(passWordText){
                withAnimation {
                    showEnterYourPassword = false
                    showPasswordFormat = true
                }
            }else if viewModel.isPasswordValid(passWordText){
                withAnimation {
                    showPasswordFormat = false
                }
            }
        }
        if confirmPassWordText.isEmpty{
            withAnimation {
                showEnterConfirmPassword = true
                showEnterConfirmPasswordFormat = false
            }
        }else if !confirmPassWordText.isEmpty{
            showEnterConfirmPassword = false
            if !viewModel.isPasswordValid(confirmPassWordText){
                withAnimation {
                    showEnterConfirmPassword = false
                    showEnterConfirmPasswordFormat = true
                }
            }else if viewModel.isPasswordValid(confirmPassWordText){
                withAnimation {
                    showEnterConfirmPasswordFormat = false
                }
                if passWordText != confirmPassWordText {
                    withAnimation {
                        showPasswordDonotMatch = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        showPasswordDonotMatch = false
                    }
                }else  if passWordText == confirmPassWordText{
                    addItem()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(DataManager())
    }
}


