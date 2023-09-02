//
//  MainView.swift
//  HomeManager
//
//  Created by 大橋諒雅 on R 5/08/23.
//

import SwiftUI
import NCMB

struct MainView: View {
    @State var user = NCMBUser.currentUser
    
    var body: some View {
        VStack{
            Spacer()
            Text("MainView")
                .font(.title)
                .foregroundColor(Color.blue)
            if let userName = user?.userName {
                Text("\(userName)さん、ようこそ")
                    .font(.title2)
            }
            Spacer()
            Text("Hello, World!")
            Spacer()
        }
        .onAppear {
            print("MainView")
        }
        .navigationBarBackButtonHidden(true) 
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


