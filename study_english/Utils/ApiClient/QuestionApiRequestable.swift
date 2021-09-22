//
//  QuestionApiRequestable.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/22.
//

import RxSwift

protocol QuestionApiRequestable {
    
    var disposeBag: DisposeBag { get }
    var requester: QuestionApi { get }
    
    func get(parameters: [String : String]?, onNext: @escaping (QuestionResponse) -> ())
    func handleError(error: Error) -> Void
}

extension QuestionApiRequestable {
    
    func get(parameters: [String : String]?, onNext: @escaping (QuestionResponse) -> ()) {
        requester.get(path: "", parameters: parameters)
            .subscribe(onNext: onNext, onError: handleError)
            .disposed(by: disposeBag)
    }
}
