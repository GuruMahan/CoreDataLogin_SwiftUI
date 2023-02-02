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
                                .frame(width: 380, height: UIScreen.main.bounds.height - 350)
                                .background(Color.white)
                                .cornerRadius(10)
                              
                        }
                        Spacer()
                    }
                }
            }
            
            @ViewBuilder var bodyView: some View{
                
                VStack(alignment:.center){
                    Text("Sign Up")
                        .font(.system(size: 20))
                        .padding()
                    VStack(alignment:.leading){
                        Text("Email")
                            .font(.system(.subheadline))
        //                    .padding(.leading,-13)
                        VStack(alignment: .leading,spacing: 0){
                            TextField("  Enter Email Id", text: $emailText)
                                .font(.system(.subheadline))
                                .frame(maxWidth: .infinity,maxHeight: 40,alignment: .leading)
                                .overlay(RoundedRectangle(cornerRadius:5)
                                    .stroke(Color.gray,lineWidth: 2)
                                )
                            
                            if showEmailFormat{
                                displayAlertMessage(userMessage:"Invalid Format" )
                                       .font(.system(size: 16))
                                       .foregroundColor(.red)
                            }
                            if showEnterYourEmail{
                                displayAlertMessage(userMessage: "Enter  Email" )
                                    .font(.system(size: 16))
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Text(
                            "PassWord")
                        .font(.system(.subheadline))
        //                .padding()
                        .padding(2)
                        VStack(alignment: .leading,spacing: 0){
                            TextField("  Enter PassWord", text: $passWordText)
                                .font(.system(.subheadline))
                                .frame(maxWidth: .infinity,maxHeight: 40)
                                .overlay(RoundedRectangle(cornerRadius:5).stroke(Color.gray,lineWidth: 2))
                          
                         if showPasswordFormat{
                             displayAlertMessage(userMessage:"Invalid Format" )
                                    .font(.system(size: 16))
                                    .foregroundColor(.red)
                         }
                            if showEnterYourPassword{
                                displayAlertMessage(userMessage: "Enter Password" )
                                       .font(.system(size: 16))
                                       .foregroundColor(.red)
                            }
                        }
                        
                        
                        Text(
                            "Confirm PassWord")
                        .font(.system(.subheadline))
        //                .padding()
                        .padding(2)
                        VStack(alignment: .leading,spacing: 0){
                            TextField("  Enter ConfirmPassWord", text: $confirmPassWordText)
                                .font(.system(.subheadline))
                                .frame(maxWidth: .infinity,maxHeight: 40)
                            
                                .overlay(RoundedRectangle(cornerRadius:5).stroke(Color.gray,lineWidth: 2))
                            
                            if showEnterConfirmPasswordFormat{
                                displayAlertMessage(userMessage:"Invalid Format" )
                                       .font(.system(size: 16))
                                       .foregroundColor(.red)
                            }
                               if showEnterConfirmPassword{
                                   displayAlertMessage(userMessage: "Enter confirmPassword" )
                                          .font(.system(size: 16))
                                          .foregroundColor(.red)
                               }
                            
                        }
                        
                    }
                    .padding(10)
                    
                    ZStack{
                        Button {
                           
                            check()
                        } label: {
                            Text("Sing up")
                              
                                .frame(width: 240,height:40)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(5)
                                .padding(.horizontal,40)
                        }
                        if showPasswordDonotMatch{
                            displayAlertMessage(userMessage: "Password Don't Match")
                                .frame(width: 240,height: 40)
                                .foregroundColor(.red)
                                .background(Color.white)
                                .cornerRadius(5)
                        }
                    }
                    Divider()
                    Text("Already have an account?")
                    .padding(2)
                Button {
                    if presentationMode.wrappedValue.isPresented {
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Login")
                }
                Spacer()
                }
                .padding()
            }
    @ViewBuilder func displayAlertMessage(userMessage:String) -> some View{
           VStack{
               Text("\(userMessage)")
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
                    //  showEmailValidationErrorLabel = false
                  
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

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
