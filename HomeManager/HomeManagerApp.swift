//
//  HomeManagerApp.swift
//  HomeManager
//
//  Created by 大橋諒雅 on R 5/08/23.
//

import SwiftUI
import NCMB

@main
struct HomeManagerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // APIキーの設定とSDK初期化
        init() {
            NCMB.initialize(applicationKey: "95df721cd4feafb5304e7310f1831d2a1f126856ff6d0f57b9154a9da86287a6",
                            clientKey: "d3d0cfa35e6f07f5f8cc5a119a48c5610b1d9afd2e27940107a1f796fbbc8864")
        }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // 起動時に1回だけ処理
        print("---アプリ起動時の処理開始---")
        //ログイン状態の確認
        let currentUser = NCMBUser.currentUser
        if currentUser == nil {
            //未ログイン
            print("アプリ起動時：未ログイン状態です")
            //ログイン or サインアップ処理を記述
        } else {
            //ログイン中
            print("アプリ起動時：ログイン中です")
            
            //セッションの確認
            var session :NCMBQuery<NCMBObject> = NCMBQuery.getQuery(className: "SessionCheck")
            session.limit = 1
            session.findInBackground(callback: { result in
                switch result {
                case .success(_):
                    print("セッション有効")
                case .failure(_):
                    print("セッション無効")
                    //ログアウト
                    NCMBUser.logOutInBackground(callback: { result in
                        print("強制ログアウト")
                    })
                }

            })
        }
        print("---アプリ起動時の処理終了---")
        return true
    }
}
