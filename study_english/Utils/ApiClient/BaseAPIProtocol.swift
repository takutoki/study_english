//
//  BaseAPIProtocol.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/22.
//

import Foundation
import RxSwift
import Alamofire

protocol BaseAPIProtocol {
    
    associatedtype ResponseData: Codable
    
    var baseURL: String { get }
    var headers: HTTPHeaders? { get }
    
    func request(url: String, method: HTTPMethod, parameters: [String : String]? ) -> Observable<ResponseData>
    func handleResponse(_ observer: AnyObserver<ResponseData>, _ response: AFDataResponse<Any>)
    
    func get(path: String, parameters: [String: String]?) -> Observable<ResponseData>
}

extension BaseAPIProtocol {
    
    func request(url: String, method: HTTPMethod, parameters: [String : String]? ) -> Observable<ResponseData> {
        return Observable.create{ observer in
            _ = AF.request(url, method: method, parameters: parameters, headers: self.headers)
                .responseJSON{ response in self.handleResponse(observer, response) }
                .resume()
            
            return Disposables.create()
        }
    }
    
    func handleResponse(_ observer: AnyObserver<ResponseData>, _ response: AFDataResponse<Any>) {
        switch response.result {
        case .success:
            decode(data: response.data, observer: observer)
        case .failure(let error):
            observer.onError(error)
        }
    }
    
    func decode(data: Data?, observer: AnyObserver<ResponseData>) {
        if let responseJson = data {
            if let res = try? JSONDecoder().decode(ResponseData.self, from: responseJson) {
                observer.onNext(res)
            } else {
                let e = CustomError.decodeError
                observer.onError(e)
            }
        } else {
            let e = CustomError.decodeError
            observer.onError(e)
        }
    }
}
