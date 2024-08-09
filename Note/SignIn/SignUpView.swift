//
//  SignUpView.swift
//  DemoFireBase
//
//  Created by 王崇亘 on 2024/8/8.
//

import SwiftUI

struct SignUpView: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var showingSheet = false
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Note")
                .font(.system(size: 65))
                .bold()
                .foregroundColor(.mint)
                .opacity(0.8)
                .padding()
            
            Image(systemName: "doc.text.below.ecg.fill.rtl")
                .font(.system(size: 100))
                .foregroundColor(.mint)
                .opacity(0.7)
            
            Spacer()
            
            Section {
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .font(.title2)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 3)
                    )
                    .padding()
                    .padding(.horizontal)
                
                
                SecureField("Password", text: $password)
                    .font(.title2)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 3)
                    )
                    .padding()
                    .padding(.horizontal)
            }
            
            
            HStack{
                Section {
                    Button{
                        authModel.signIn(emailAddress: emailAddress, password: password)
                    }label:{
                        ButtonView(text: "Login")
                    }
                }
                .padding()
                
                Section{
                    Button{
                        authModel.signUp(emailAddress: emailAddress, password: password)
                    }label:{
                        ButtonView(text: "Sign Up")
                    }
                }
            }
            .navigationTitle("Welcome")
            .toolbar{
                ToolbarItemGroup(placement:.cancellationAction) {
                    Button{
                        showingSheet.toggle()
                    }label:{
                        Text("Forgot password?")
                    }
                    .sheet(isPresented: $showingSheet) {
                        ForgotPasswordView()
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
        .background(
            Image("bg")
                .resizable()
                .scaledToFill()
                .opacity(0.6)
                .ignoresSafeArea()
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
