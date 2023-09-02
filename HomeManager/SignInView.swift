//
//  SignInView.swift
//  HomeManager
//
//  Created by 大橋諒雅 on R 5/08/24.
//

import SwiftUI
import NCMB

struct SignInView: View {
    
    @State private var userName :String = ""
    @State private var password :String = ""
    
    @State private var toMain = false
    @State private var toSignUp = false
    @State private var showAlert = false
    @State private var isLoading = false
    @State private var showSprash :Bool = true
    
    @State private var user = NCMBUser()
    
    
    var body: some View {
        if showSprash {
            SprashView()
                .onAppear{
                    let currentUser = NCMBUser.currentUser
                    if currentUser != nil {
                        //セッションの確認
                        var session :NCMBQuery<NCMBObject> = NCMBQuery.getQuery(className: "SessionCheck")
                        session.limit = 1
                        session.findInBackground(callback: { result in
                            switch result {
                            case .success(_):
                                print("セッション有効")
                                var transaction = Transaction()
                                transaction.disablesAnimations = true
                                withTransaction(transaction) {
                                    // ここで画面遷移を発生させる
                                    toMain = true
                                }

                            case .failure(_):
                                print("セッション無効")
                                //ログアウト
                                NCMBUser.logOutInBackground(callback: { result in
                                    print("強制ログアウト")
                                })
                            }
                            
                        })
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        withAnimation{showSprash = false}
                    }
                    

                    
                }
        } else {
            NavigationStack{
                ZStack{
                    VStack{
                        Spacer()
                        
                        Text("Welcom")
                            .frame(width: 500, height: 100.0)
                            .multilineTextAlignment(.trailing)
                            .font(.title)
                            .fontWeight(.heavy)
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        
                        
                        
                        Spacer()
                        
                        
                        TextField("ユーザ名", text: $userName)
                            .frame(width: 350.0)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal)
                        
                        SecureField("パスワード", text: $password)
                            .frame(width: 350.0)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal)
                        
                        Button(action: {
                            isLoading.toggle()
                            
                            //ユーザ名を設定
                            user.userName = userName
                            //パスワードを設定
                            user.password = password
                            //ログイン
                            NCMBUser.logInInBackground(
                                userName: userName,
                                password: password,
                                callback: { result in
                                    switch result {
                                    case.success:
                                        // ログインに成功した場合の処理
                                        print("ログインに成功しました")
                                        toMain.toggle()
                                        showAlert = false
                                        isLoading = false
                                        
                                    case let.failure(error):
                                        // ログインに失敗した場合の処理
                                        print("ログインに失敗しました: \(error)")
                                        showAlert = true
                                        isLoading = false
                                    }
                                })
                            
                            
                        }) {
                            HStack{
                                Spacer()
                                ZStack{
                                    RoundedRectangle(cornerRadius: 7)
                                    Text("ログイン")
                                        .fontWeight(.bold)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                                }
                                .frame(width: 90.0, height: 30.0)
                                .padding(.top, 10)
                                .padding(.trailing, 75)
                                
                            }
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("ログインエラー"),
                                  message: Text("IDまたはパスワードが間違っています。"),
                                  dismissButton: .default(Text("OK")))
                        }
                        
                        
                        Spacer()
                        
                        Button(action: {
                            
                            toSignUp.toggle()
                            
                        }) {
                            Text("新規登録")
                        }
                        
                    }
                    .navigationDestination(isPresented: $toMain,
                                           destination: {
                        MainView()
                    })
                    .sheet(isPresented: $toSignUp) {
                        SignUpView()
                    }
                    
                    if isLoading{
                        Color.gray.opacity(0.5)
                            .ignoresSafeArea()
                        ProgressView()
                    }
                    
                    
                }
                .onAppear {
                    print("SignInView")
                }
                
                
                
                
            }
        }
        
    }
}

struct temp_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
