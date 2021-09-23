//
//  QuestionModel.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/22.
//

import RxSwift
import RxRelay

protocol QuestionModelProtocol: AnyObject {
    
    var questionStream: Observable<QuestionResponse> { get }
    var errorStream: Observable<String> { get }
}

class QuestionModel: QuestionModelProtocol, QuestionApiRequestable {
    
    private let question: BehaviorRelay<QuestionResponse> =
        BehaviorRelay(value: QuestionResponse.initialValue())
    private let someError: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var questionStream: Observable<QuestionResponse> { question.asObservable() }
    var errorStream: Observable<String> { someError.asObservable() }
    
    var disposeBag: DisposeBag = DisposeBag()
    var requester: QuestionApi = QuestionApi()
    
    init(){
        get(path: "", parameters: [:], onNext: onNext)
    }
    
    func onNext(response: QuestionResponse) -> () {
        question.accept(response)
    }
    
    func handleError(error: Error) {
        someError.accept(error.localizedDescription)
    }
}
