//
//  MainView.swift
//  SecretNumbers
//
//  Created by Taiyo Koshiba on 2023/05/30.
//

//import SwiftUI
//
//struct MainView: View {
//    var body: some View {
//        VStack {
//            Spacer()
//            // 画面遷移
//            NavigationView {
//                VStack {
//                    Spacer()
//
//                    // タイトル表示
//                    Text("シークレットナンバーズ")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(20)
//
//
//                    // システムアイコンを3つ横に並べて表示する
//                    HStack {
//                        Image(systemName: "questionmark")
//                        Image(systemName: "questionmark")
//                        Image(systemName: "questionmark")
//                    }
//                    .font(.largeTitle)
//                    .padding()
//
//
//                    // ゲームの説明
//                    Text("3桁の数字を当てるゲーム")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .padding()
//                        .multilineTextAlignment(.leading)
//
//
//
//                    Spacer()
//
//
//                    NavigationLink(destination: GameView()) {
//                        Text("ゲームスタート")
//                            .font(.title)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                    }
//                    NavigationLink(destination: AboutView()) {
//                        Text("遊び方")
//                            .font(.title)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                    }.padding()
//
//                    Spacer()
//                }
//            }
//            Spacer()
//        }
//    }
//}


import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 背景
                self.backGroundColor().edgesIgnoringSafeArea(.all)
                
                // テキスト
                VStack{
                    Text("welcome to Secret Numbers")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    VStack {
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
    
    private func backGroundColor() -> LinearGradient {
        let start = UnitPoint.init(x: 0.0, y: 0.0)
        let end = UnitPoint.init(x: 1.0, y: 1.0)
        
        // convert UIColor to Color
        let colors = Gradient(colors: [Color.blue, Color(UIColor.purple)])
        let gradientColor = LinearGradient(gradient: colors, startPoint: start, endPoint: end)
        
        return gradientColor
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
