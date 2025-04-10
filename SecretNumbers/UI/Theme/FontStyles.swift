//
//  FontStyles.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import SwiftUI

extension View {
    // タイトル用フォント
    func titleStyle() -> some View {
        self.font(.system(size: 32, weight: .bold, design: .rounded))
            .foregroundColor(.primaryText)
    }

    // サブタイトル用フォント
    func subtitleStyle() -> some View {
        self.font(.system(size: 22, weight: .semibold, design: .rounded))
            .foregroundColor(.primaryText)
    }

    // 本文用フォント
    func bodyStyle() -> some View {
        self.font(.system(size: 16, weight: .regular, design: .rounded))
            .foregroundColor(.primaryText)
    }

    // ボタンテキスト用フォント
    func buttonTextStyle() -> some View {
        self.font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(.primaryText)
    }

    // 数字表示用フォント
    func numberDisplayStyle() -> some View {
        self.font(.system(size: 28, weight: .bold, design: .monospaced))
            .foregroundColor(.primaryText)
    }

    // スコア表示用フォント
    func scoreStyle() -> some View {
        self.font(.system(size: 18, weight: .medium, design: .rounded))
            .foregroundColor(.primaryText)
    }
}
