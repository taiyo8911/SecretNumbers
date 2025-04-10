//
//  GameViewModel.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    // ゲームの最大回数
    static let challengeNumber = 7

    // 正解文字の桁数
    private let stringLength = 3
    
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
    
    // スコアの構造体
    struct Score: Identifiable {
        var id: Int
        var input: String
        var hits: Int
        var blows: Int
    }
    
    init() {
        resetGame()
    }
    
    // ゲームリセット関数
    func resetGame() {
        // 問題の番号を作る
        correctNumbers = createCorrectNumbers()
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
    }
    
    // 規定の文字数でランダムな文字の配列を作る関数
    func createCorrectNumbers() -> [String] {
        // 文字の保存用配列
        var numbers: Set<String> = []
        // 1つの乱数を保存する変数
        var randNumber: Int
        // numbersの要素数が3になるまで繰り返す
        while numbers.count < stringLength {
            // 0から9の範囲で整数の乱数を生成
            randNumber = Int.random(in: 0...9)
            // 文字列に変換して配列に追加
            numbers.insert(String(randNumber))
        }
        // Set型からArray型に変換
        let targetNumString = Array(numbers)

        return targetNumString
    }

    // 文字数チェック
    func checkStringLength(_ target: String) -> Bool {
        return userInputCount >= stringLength
    }

    // 同じ文字じゃないかチェック
    func checkSameString(_ target: String) -> Bool {
        return userInputNumbers.contains(target)
    }

    // すべてのチェックが通った場合のみ入力文字を表示する
    func inputCheck(_ target: String) {
        if isGameClear || isGameOver {
            return
        }
        
        if checkStringLength(target) {
            // 入力制限のメッセージを表示
            showTemporaryMessage("これ以上入力できません")
            return
        }
        
        if checkSameString(target) {
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

    // ヒット数とブロー数を計算する関数
    func calculateHitAndBlow(input: [String], answer: [String]) -> (hits: Int, blows: Int) {
        // ヒット数を数える（同じインデックスに同じ要素があるか数える）
        let hitCount = zip(input, answer).filter { $0 == $1 }.count

        // ブロー数を数える（配列内のどこかに同じ要素があるか数える）
        var blowCount = 0
        for i in 0..<input.count {
            if answer.contains(input[i]) && input[i] != answer[i] {
                blowCount += 1
            }
        }

        return (hitCount, blowCount)
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
        let result = calculateHitAndBlow(input: userInputNumbers, answer: correctNumbers)

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
            
            // 結果オーバーレイを表示
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showResultOverlay = true
            }
        } else if remaining == 0 {
            isGameOver = true
            message = "ゲームオーバー"
            showMessage = true
            
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

