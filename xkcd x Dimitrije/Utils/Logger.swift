//
//  Logger.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//  Lets finish a Logger so we can implement it while we write functions
//

import Foundation

class Logger {
    
    enum LogReason {
        case info
        case warning
        case error
        case armageddon
    }
    
    static func log(_ text: String, reason: LogReason = .info) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SS"
        let timestamp = dateFormatter.string(from: Date())
        let message = "\(reason.symbol) \(timestamp) – \(text)"
        print(message)
    }
}

extension Logger.LogReason {
    var symbol: Character {
        switch self {
        case .info:
            return "🤔"
        case .warning:
            return "😳"
        case .error:
            return "😵"
        case .armageddon:
            return "🤯"
        }
    }
}
