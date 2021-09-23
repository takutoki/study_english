//
//  SelectAnswer.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/23.
//

import Foundation

struct SelectAnswer {
    
    init(_ value: QuestionResponse.Answer) {
        self.text = value.text
        self.correct = value.correct
    }
    
    let text: String
    let correct: Bool
    let selected: Bool = false
}
