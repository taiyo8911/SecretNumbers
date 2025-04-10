//
//  ColorPalette.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import SwiftUI

extension Color {
    // メインカラー - ゲームの主要な部分に使用
    static let primaryColor = Color(red: 41/255, green: 128/255, blue: 185/255)

    // セカンダリカラー - アクセント、ハイライトに使用
    static let secondaryColor = Color(red: 231/255, green: 76/255, blue: 60/255)

    // 背景グラデーション用の色
    static let gradientStart = Color(red: 52/255, green: 152/255, blue: 219/255)
    static let gradientEnd = Color(red: 142/255, green: 68/255, blue: 173/255)

    // テキストカラー
    static let primaryText = Color.white
    static let secondaryText = Color(red: 236/255, green: 240/255, blue: 241/255)

    // 機能ボタン色
    static let clearButton = Color(red: 231/255, green: 76/255, blue: 60/255)  // 赤系
    static let enterButton = Color(red: 46/255, green: 204/255, blue: 113/255) // 緑系

    // 数字ボタン色
    static let numberButton = Color(red: 52/255, green: 73/255, blue: 94/255)

    // ゲームフィードバック用の色
    static let hitColor = Color(red: 231/255, green: 76/255, blue: 60/255)     // 赤系
    static let blowColor = Color(red: 241/255, green: 196/255, blue: 15/255)   // 黄色系
}
