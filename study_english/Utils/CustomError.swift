//
//  CustomError.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/22.
//

import Foundation

enum CustomError: Int, LocalizedError {
    case decodeError = 1
    
    var errorDescription: String? {
        switch self {
        case .decodeError: return "Decording failed"
        }
    }
}
