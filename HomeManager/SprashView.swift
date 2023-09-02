//
//  SprashView.swift
//  HomeManager
//
//  Created by 大橋諒雅 on R 5/08/24.
//

import SwiftUI

struct SprashView: View {
    var body: some View {
        Image(systemName: "play")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(.blue)
    }
}

struct SprashView_Previews: PreviewProvider {
    static var previews: some View {
        SprashView()
    }
}
