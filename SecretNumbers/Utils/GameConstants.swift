//
//  GameConstants.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import Foundation
import SwiftUI

/// ゲーム全体で使用する定数
enum GameConstants {
    /// 正解の数字の桁数
    static let digitCount = 3
    
    /// 挑戦できる最大回数
    static let maxAttempts = 7
    
    /// キーパッドのレイアウト
    static let keypadLayout = [
        ["5", "6", "7", "8", "9"],
        ["0", "1", "2", "3", "4"]
    ]
    
    /// ゲーム結果のステータス
    enum GameStatus {
        case playing
        case cleared
        case gameOver
    }
    
    /// ゲームの色
    enum Colors {
        static let hit = Color.red
        static let blow = Color.yellow
        static let background = LinearGradient(
            gradient: Gradient(colors: [.blue, .purple]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
