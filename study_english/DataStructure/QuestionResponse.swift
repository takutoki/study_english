//
//  QuestionResponse.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/22.
//

import Foundation

struct QuestionResponse: Codable {
    
    static func initialValue() -> Self {
        QuestionResponse.init(id: 0, question: Question.init(word: "", question: "", audio: ""), answers: [])
    }
    
    let id: Int
    let question: Question
    let answers: [Answer]
    
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
