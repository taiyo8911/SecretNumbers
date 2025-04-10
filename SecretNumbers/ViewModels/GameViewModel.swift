//
//  GameViewModel.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


//
//  GameViewModel.swift
//  SecretNumbers
//
//  Created on 2025/04/10.
//

import Foundation
import SwiftUI
import Combine

/// ゲーム画面のViewModelクラス
class GameViewModel: ObservableObject {
    
    /// ゲームモデル
    private let gameModel = GameModel()
    
    /// ゲームメッセージ
    @Published var message: String = ""
    
    /// ユーザーの入力値
    @Published var userInput: [String] = Array(repeating: "", count: GameConstants.digitCount)
    
    /// 入力文字数カウント
    @Published var inputCount: Int = 0
    
    /// スコア履歴
    @Published var scores: [Score] = []
    
    /// ゲームクリアフラグ
    @Published var isGameCleared: Bool = false
    
    /// ゲームオーバーフラグ
    @Published var isGameOver: Bool = false
    
    /// 初期化
    init() {
        resetGame()
    }
    
    /// ゲームをリセットする
    func resetGame() {
        gameModel.resetGame()
        userInput = Array(repeating: "", count: GameConstants.digitCount)
        inputCount = 0
        updateGameState()
    }
    
    /// 数字キーが押された時の処理
    /// - Parameter digit: 押された数字
    func digitPressed(_ digit: String) {
        // ゲーム終了時は何もしない
        if isGameCleared || isGameOver {
            return
        }
        
        // 入力桁数チェック
        if inputCount >= GameConstants.digitCount {
            return
        }
        
        // 入力済みの数字かチェック
        if userInput.contains(digit) {
            return
        }
        
        // 入力を追加
        userInput[inputCount] = digit
        inputCount += 1
    }
    
    /// 入力をクリアする
    func clearInput() {
        // ゲーム終了時は何もしない
        if isGameCleared || isGameOver {
            return
        }
        
        userInput = Array(repeating: "", count: GameConstants.digitCount)
        inputCount = 0
    }
    
    /// 入力を判定する
    func submitInput() {
        // ゲーム終了時または入力が完了していない場合は何もしない
        if isGameCleared || isGameOver || inputCount != GameConstants.digitCount {
            return
        }
        
        // 入力を評価
        let _ = gameModel.evaluateUserInput(userInput)
        
        // ゲーム状態を更新
        updateGameState()
        
        // 入力をクリア（ゲームが続行中の場合）
        if !isGameCleared && !isGameOver {
            clearInput()
        }
    }
    
    /// ゲーム状態を更新する
    private func updateGameState() {
        scores = gameModel.scores
        message = gameModel.statusMessage()
        
        switch gameModel.gameStatus {
        case .playing:
            isGameCleared = false
            isGameOver = false
        case .cleared:
            isGameCleared = true
            isGameOver = false
        case .gameOver:
            isGameCleared = false
            isGameOver = true
        }
    }
    
    /// デバッグ用：正解の数字を表示する
    func debugCorrectNumbers() -> String {
        return gameModel.debugCorrectNumbers()
    }
}
