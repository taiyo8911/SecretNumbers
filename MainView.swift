//
//  MainView.swift
//  SecretNumbers
//
//  Created by Taiyo Koshiba on 2023/05/30.
//


import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 背景グラデーション
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                    .edgesIgnoringSafeArea(.all)
                
                
                // テキスト
                VStack{
                    // ???のアイコンを表示
                    Image(systemName: "questionmark")
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                        .foregroundColor(Color.white)
                    
                    Text("シークレットナンバーズ")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding()
                    
                    Text("3つの数字を当てるゲームです。")
                        .foregroundColor(Color.white)
                        .padding()
                    
                    
                    Group {
                        NavigationLink(destination: GameView()) {
                            Text("遊ぶ")
                                .font(.headline)
                                .frame(width: 200.0, height: 50)
                                .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                                .shadow(radius: 20)
                        }
                        .padding()
                        
                        NavigationLink(destination: AboutView()) {
                            Text("ルール")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(width: 200.0, height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                        .padding()
                    }
                }
            }
        }
    }
}




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
