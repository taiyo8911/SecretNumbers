//
//  ContentView.swift
//  SecretNumbers
//
//  Created by Taiyo Koshiba on 2023/05/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            // 画面遷移
            NavigationView {
                VStack {
                    Spacer()
                    
                    // タイトル表示
                    Text("シークレットナンバーズ")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(20)
                    
                    
                    // システムアイコンを3つ横に並べて表示する
                    HStack {
                        Image(systemName: "questionmark")
                        Image(systemName: "questionmark")
                        Image(systemName: "questionmark")
                    }
                    .font(.largeTitle)
                    .padding()
                    
                    
                    // ゲームの説明
                    Text("3桁の数字を当てるゲーム")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .multilineTextAlignment(.leading)
                    
                    
                    
                    Spacer()
                    
                    
                    NavigationLink(destination: GameView()) {
                        Text("ゲームスタート")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: AboutView()) {
                        Text("遊び方")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }.padding()
                    
                    Spacer()
                }
            }
            Spacer()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
