//
//  ProgressBar.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct ProgressBar: View {
    let current: Int
    let total: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 背景のバー
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .cornerRadius(5)

                // 進捗を表すバー
                Rectangle()
                    .foregroundColor(Color.secondaryColor)
                    .frame(width: min(CGFloat(current) / CGFloat(total) * geometry.size.width, geometry.size.width))
                    .cornerRadius(5)
                    .animation(.linear, value: current)
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // 進捗なし
            ProgressBar(current: 0, total: 7)
                .frame(height: 18)

            // 一部進捗
            ProgressBar(current: 3, total: 7)
                .frame(height: 18)

            // 完了
            ProgressBar(current: 7, total: 7)
                .frame(height: 18)
        }
        .padding()
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
