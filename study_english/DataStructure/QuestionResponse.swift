//
//  QuestionResponse.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/22.
//

import Foundation

struct QuestionResponse: Codable {
    
    let id: Int
    let question: Question
    let answer: [Answer]
    
    struct Question: Codable {
        let word: String
        let question: String
        let audio: String
    }
    
    struct Answer: Codable {
        let text: String
        let correct: Bool
    }
}
