//
//  QuestionApi.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/22.
//

import RxSwift
import Alamofire

class QuestionApi: BaseAPIProtocol {
    
    typealias ResponseData = QuestionResponse
    
    var baseURL: String = "https://mmpotgg62l.execute-api.ap-northeast-1.amazonaws.com/default/program-detail-for-test"
    var headers: HTTPHeaders? = [.accept("application/json")]
    
    func get(path: String, parameters: [String: String]?) -> Observable<ResponseData> {
        return request(url: baseURL + path, method: .get, parameters: parameters)
    }
}

