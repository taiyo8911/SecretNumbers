//
//  SplashView.swift
//  SecretNumbers
//
//  Created by Taiyo Koshiba on 2023/06/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.black)
        }
        .onAppear {
            // スプラッシュ画面が表示された2秒後にContentViewに遷移する
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = true
            }
        }
        .background(Color.white)
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
