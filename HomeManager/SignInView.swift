//
//  SignInView.swift
//  HomeManager
//
//  Created by 大橋諒雅 on R 5/08/24.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack{
            VStack{
                Text("SignIn")
                    .font(.title)
                    .foregroundColor(Color.blue)
                Text("UserName")
                Text("PassWord")
            }
            .padding(.bottom)

            Text("SignUp")
                .font(.title)
                .foregroundColor(Color.blue)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
