//
//  GameLogicManager.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/12.
//

import Foundation

class GameLogicManager {
    // 正解文字の桁数
    private let stringLength = 3
    
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
    func checkStringLength(currentCount: Int) -> Bool {
        return currentCount >= stringLength
    }

    // 入力された文字が同じじゃないかチェック
    func checkSameString(_ target: String, inputNumbers: [String]) -> Bool {
        return inputNumbers.contains(target)
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
}
