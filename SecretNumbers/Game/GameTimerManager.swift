//
//  GameTimerManager.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/12.
//


import Foundation

class GameTimerManager: ObservableObject {
    // タイマー関連のプロパティ
    @Published var elapsedSeconds: Int = 0
    @Published var formattedTime: String = "00:00"
    private var timer: Timer?
    
    // タイマーをリセットして開始する
    func resetTimer() {
        stopTimer()
        elapsedSeconds = 0
        formattedTime = formatTime(seconds: 0)
        startTimer()
    }
    
    // タイマーを開始する
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.elapsedSeconds += 1
            self.updateFormattedTime()
        }
    }
    
    // タイマーを停止する
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // 表示用の時間文字列を更新
    private func updateFormattedTime() {
        formattedTime = formatTime(seconds: elapsedSeconds)
    }
    
    // 秒数を「分:秒」形式にフォーマットする
    private func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
