//
//  Score.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import Foundation

/// ゲームの1ターンのスコアを表す構造体
struct Score: Identifiable {
    var id: Int
    var input: String
    var hitCount: Int
    var blowCount: Int
    
    /// 表示用のスコア文字列（例: "2ヒット 1ブロー"）
    var scoreText: String {
        return "\(hitCount)ヒット \(blowCount)ブロー"
    }
    
    /// 全てヒットしたかどうか
    var isAllHit: Bool {
        return hitCount == GameConstants.digitCount
    }
}
