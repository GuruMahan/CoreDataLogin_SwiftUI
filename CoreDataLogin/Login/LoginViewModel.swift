//
//  LoginViewModel.swift
//  CoreDataLogin
//
//  Created by Guru Mahan on 01/02/23.
//

import Foundation
import UIKit
import SwiftUI

class LoginViewModel: ObservableObject {
 @State var  emailTextField = ""
 @State var PasswordTextField = ""
    func isPasswordValid(_ password : String) -> Bool{
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{3,64}")
            return passwordTest.evaluate(with: password)
        }
    
        func isValidEmail(testStr:String) -> Bool {
            // print("validate calendar: \(testStr)")
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
    
    
//    func loginAction(){
//        let email1 = emailTextField
//        let pass = PasswordTextField.text
//
//        if email1 == ""{
//            displayAlertMessage(userMessage: "please enter Email or PhoneNumber")
//
//        }else if !isValidEmail(testStr: email1){
//
//            displayAlertMessage(userMessage: "please enter valid Email")
//
//        }else if pass == ""{
//            displayAlertMessage(userMessage: "please enter your passWord")
//
//        }else if isPasswordValid(pass){
//
//            displayAlertMessage(userMessage: " please enter Valid password")
//
//        }
////        else if (email1 !=  UserDefaults.emailData) || (email1 != UserDefaults.phoneNumberData ) && (pass != UserDefaults.PasswordData ){
////            displayAlertMessage(userMessage: "Dont have a Account")
////
////        }else if (email1 == UserDefaults.emailData ) || (email1 == UserDefaults.phoneNumberData ) && (pass == UserDefaults.PasswordData){
////            UserDefaults.isLoginUser = true
////             let homeVC = TabelViewDataLoadViewController()
////             self.navigationController?.isNavigationBarHidden = true
////            self.navigationController?.pushViewController(homeVC, animated: true)
////        }
//    }
   
    
    
}
