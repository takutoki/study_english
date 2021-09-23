//
//  QuestionViewModel.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/23.
//

import RxSwift
import RxCocoa

protocol QuestionViewModelProtocol: AnyObject {
    
    var model: QuestionModelProtocol! { get }
    var questionStream: Observable<QuestionResponse> { get }
    var errorStream: Observable<String> { get }
}

class QuestionViewModel: QuestionViewModelProtocol {
    
    var model: QuestionModelProtocol!
    var questionStream: Observable<QuestionResponse> { model.questionStream }
    var errorStream: Observable<String> { model.errorStream }
    
    init(inject: QuestionModelProtocol) {
        self.model = inject
    }
}
