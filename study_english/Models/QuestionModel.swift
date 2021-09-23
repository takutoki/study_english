//
//  QuestionModel.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/22.
//

import RxSwift
import RxRelay

protocol QuestionModelProtocol: AnyObject {
    
    var questionStream: Observable<QuestionResponse.Question> { get }
    var answerStream: Observable<[QuestionResponse.Answer]> { get }
    var errorStream: Observable<String> { get }
    
    func getQuestion()
}

class QuestionModel: QuestionModelProtocol, QuestionApiRequestable {
    
    private let question: BehaviorRelay<QuestionResponse.Question> =
        BehaviorRelay(value: QuestionResponse.Question(word: "", question: "", audio: ""))
    private let answer: BehaviorRelay<[QuestionResponse.Answer]> = BehaviorRelay(value: [])
    private let someError: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var questionStream: Observable<QuestionResponse.Question> { question.asObservable() }
    var answerStream: Observable<[QuestionResponse.Answer]> { answer.asObservable() }
    var errorStream: Observable<String> { someError.asObservable() }
    
    var disposeBag: DisposeBag = DisposeBag()
    var requester: QuestionApi = QuestionApi()
    
    init(){
        getQuestion()
    }
    
    func getQuestion() {
        get(path: "", parameters: [:], onNext: onNext)
    }
    
    func onNext(response: QuestionResponse) -> () {
        question.accept(response.question)
        answer.accept(response.answer)
    }
    
    func handleError(error: Error) {
        someError.accept(error.localizedDescription)
    }
}
