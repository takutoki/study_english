//
//  QuestionViewModel.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/23.
//

import RxSwift
import RxRelay

protocol QuestionViewModelProtocol: AnyObject {
    
    var model: QuestionModelProtocol! { get }
    var questionStream: Observable<QuestionResponse.Question> { get }
    var answerStream: Observable<[QuestionResponse.Answer]> { get }
    var errorStream: Observable<String> { get }
    
    func getQuestion()
    func select(value: [SelectAnswer])
}

class QuestionViewModel: QuestionViewModelProtocol {
    
    var model: QuestionModelProtocol!
    var questionStream: Observable<QuestionResponse.Question> { model.questionStream }
    var answerStream: Observable<[QuestionResponse.Answer]> { model.answerStream }
    var errorStream: Observable<String> { model.errorStream }
    
    private let selectAnswer: BehaviorRelay<[SelectAnswer]> = BehaviorRelay(value: [])
    
    init(inject: QuestionModelProtocol) {
        self.model = inject
    }
    
    func getQuestion() {
        model.getQuestion()
    }
    
    func select(value: [SelectAnswer]) {
        selectAnswer.accept(value)
    }
}
