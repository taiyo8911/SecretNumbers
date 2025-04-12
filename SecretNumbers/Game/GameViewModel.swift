//
//  GameViewModel.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import Foundation
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    // ゲームの最大回数
    static let challengeNumber = 7

    // 依存するマネージャークラス
    private let gameLogic = GameLogicManager()
    private let timerManager = GameTimerManager()
    private var cancellables = Set<AnyCancellable>()

    // 正解の文字を保存する配列
    @Published var correctNumbers: [String] = []

    // ユーザーの入力
    @Published var userInputNumbers: [String] = ["", "", ""]
    @Published var userInputCount = 0

    // ゲーム状態
    @Published var isGameClear = false
    @Published var isGameOver = false
    @Published var remaining: Int = challengeNumber
    @Published var scores: [Score] = []

    // メッセージ関連
    @Published var message = "残り\(challengeNumber)回"
    @Published var showMessage = false

    // 結果オーバーレイの表示フラグ
    @Published var showResultOverlay = false

    // キーボード震えアニメーション用
    @Published var shakeKeyboard = false

    // タイマー表示用（TimerManagerから受け取る）
    @Published var formattedTime: String = "00:00"

    // スコアの構造体
    struct Score: Identifiable {
        var id: Int
        var input: String
        var hits: Int
        var blows: Int
    }

    init() {
        // タイマーからの更新を監視
        timerManager.$formattedTime
            .sink { [weak self] newTime in
                self?.formattedTime = newTime
            }
            .store(in: &cancellables)

        resetGame()
    }

    // ゲームリセット関数
    func resetGame() {
        // 問題の番号を作る
        correctNumbers = gameLogic.createCorrectNumbers()
        // 入力をクリア
        userInputNumbers = ["", "", ""]
        userInputCount = 0
        // ゲーム状態をリセット
        remaining = Self.challengeNumber
        isGameClear = false
        isGameOver = false
        scores = []
        message = "残り\(Self.challengeNumber)回"
        showMessage = false
        showResultOverlay = false

        // タイマーをリセット
        timerManager.resetTimer()
    }

    // すべてのチェックが通った場合のみ入力文字を表示する
    func inputCheck(_ target: String) {
        if isGameClear || isGameOver {
            return
        }

        if gameLogic.checkStringLength(currentCount: userInputCount) {
            // 入力制限のメッセージを表示
            showTemporaryMessage("これ以上入力できません")
            return
        }

        if gameLogic.checkSameString(target, inputNumbers: userInputNumbers) {
            // 同じ数字の入力制限メッセージを表示
            showTemporaryMessage("同じ数字は使えません")
            return
        }

        userInputNumbers[userInputCount] = target
        userInputCount += 1
    }

    // 一時的なメッセージを表示する関数
    func showTemporaryMessage(_ text: String) {
        message = text
        showMessage = true
        // 2秒後に元のメッセージに戻す
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if !self.isGameClear && !self.isGameOver {
                self.message = "残り\(self.remaining)回"
            }
            self.showMessage = false
        }
    }

    // 判定処理
    func judgeInput() {
        // 入力チェック
        if isGameClear || isGameOver {
            return
        }

        if userInputCount < 3 {
            // 3桁入力されていない場合
            showTemporaryMessage("3桁の数字を入力してください")

            // キーボードを揺らすアニメーション
            withAnimation(.default) {
                shakeKeyboard.toggle()
            }

            return
        }

        // ゲームカウンタをデクリメントする
        remaining -= 1

        // ヒット数とブロー数を数える
        let result = gameLogic.calculateHitAndBlow(input: userInputNumbers, answer: correctNumbers)

        // 記録を追加する
        scores.insert(
            Score(
                id: Self.challengeNumber - remaining,
                input: userInputNumbers.joined(),
                hits: result.hits,
                blows: result.blows
            ),
            at: 0
        )

        // 結果判定
        if result.hits == 3 {
            isGameClear = true
            message = "クリア！ \(Self.challengeNumber - remaining)回目で成功"
            showMessage = true

            // タイマーを停止
            timerManager.stopTimer()

            // 結果オーバーレイを表示
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showResultOverlay = true
            }
        } else if remaining == 0 {
            isGameOver = true
            message = "ゲームオーバー"
            showMessage = true

            // タイマーを停止
            timerManager.stopTimer()

            // 結果オーバーレイを表示
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showResultOverlay = true
            }
        } else {
            message = "残り\(remaining)回"

            // ユーザー入力を消去する
            userInputNumbers = ["", "", ""]
            // 入力文字のカウントを初期化
            userInputCount = 0
        }
    }

    // 入力をクリアする
    func clearInput() {
        if isGameClear || isGameOver {
            return
        }
        userInputNumbers = ["", "", ""]
        userInputCount = 0
    }
}
