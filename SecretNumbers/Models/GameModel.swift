//
//  GameModel.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import Foundation

/// ゲームのコアロジックを管理するモデル
class GameModel {
    
    /// 正解の数字配列
    private(set) var correctNumbers: [String] = []
    
    /// スコア履歴
    private(set) var scores: [Score] = []
    
    /// 残りの挑戦回数
    private(set) var remainingAttempts: Int = GameConstants.maxAttempts
    
    /// ゲームのステータス
    private(set) var gameStatus: GameConstants.GameStatus = .playing
    
    /// 初期化
    init() {
        resetGame()
    }
    
    /// ゲームをリセットする
    func resetGame() {
        correctNumbers = createCorrectNumbers()
        scores = []
        remainingAttempts = GameConstants.maxAttempts
        gameStatus = .playing
    }
    
    /// ランダムな正解の数字を生成する
    private func createCorrectNumbers() -> [String] {
        var numbers = Set<String>()
        
        while numbers.count < GameConstants.digitCount {
            let randNumber = Int.random(in: 0...9)
            numbers.insert(String(randNumber))
        }
        
        return Array(numbers)
    }
    
    /// ユーザー入力を評価して結果を返す
    /// - Parameter userInput: ユーザーの入力した数字の配列
    /// - Returns: 評価結果のスコア
    func evaluateUserInput(_ userInput: [String]) -> Score {
        guard userInput.count == GameConstants.digitCount else {
            fatalError("Invalid user input: \(userInput)")
        }
        
        // 残り挑戦回数を減らす
        remainingAttempts -= 1
        
        // ヒット数とブロー数を計算
        let hitCount = zip(userInput, correctNumbers).filter { $0 == $1 }.count
        
        let blowCount = userInput.filter { correctNumbers.contains($0) }.count - hitCount
        
        // スコアを作成
        let score = Score(
            id: scores.count + 1,
            input: userInput.joined(),
            hitCount: hitCount,
            blowCount: blowCount
        )
        
        // スコア履歴に追加
        scores.insert(score, at: 0)
        
        // ゲーム状態を更新
        if score.isAllHit {
            gameStatus = .cleared
        } else if remainingAttempts <= 0 {
            gameStatus = .gameOver
        }
        
        return score
    }
    
    /// 現在のゲームステータスに応じたメッセージを返す
    /// - Returns: 表示用メッセージ
    func statusMessage() -> String {
        switch gameStatus {
        case .playing:
            return "残り\(remainingAttempts)回"
        case .cleared:
            return "クリア！ \(GameConstants.maxAttempts - remainingAttempts)回"
        case .gameOver:
            return "ゲームオーバー"
        }
    }
    
    /// デバッグ用：正解の数字を文字列で返す
    func debugCorrectNumbers() -> String {
        return correctNumbers.joined()
    }
}
