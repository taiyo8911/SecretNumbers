//
//  SplashView.swift
//  SecretNumbers
//
//  Created by Taiyo Koshiba on 2023/06/25.
//

import SwiftUI

struct SplashView: View {
    // スプラッシュ画面表示フラグ
    @State private var isActive = false
    
    // ダークモード判定
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .padding()
        }
        .onAppear {
            // スプラッシュ画面が表示された2秒後にContentViewに遷移する
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = true
            }
        }
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $isActive, content: {
            MainView()
        })
    }
}



struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
