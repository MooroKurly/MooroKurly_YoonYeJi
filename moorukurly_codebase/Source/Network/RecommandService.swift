//
//  RecommandService.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/18.
//

import Foundation
import Alamofire

struct RecommandService {
    
    static let shared = RecommandService()
    
    func getAdBanner(completion: @escaping (Result<[AdDataModel], Error>) -> Void){
        let header : HTTPHeaders = ["Content-Type": "application/json", "x-auth-token": UserDefaults.standard.string(forKey: "token")!]
        let dataRequest = AF.request(APIConstants.adURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseDecodable { (response: AFDataResponse<[AdDataModel]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func getThisItem(completion: @escaping (Result<[ProductModelData], Error>) -> Void){
        let header : HTTPHeaders = ["Content-Type": "application/json", "x-auth-token": UserDefaults.standard.string(forKey: "token")!]
        let dataRequest = AF.request(APIConstants.thisURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseDecodable { (response: AFDataResponse<[ProductModelData]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func getBigSaleItem(completion: @escaping (Result<[ProductModelData], Error>) -> Void){
        let header : HTTPHeaders = ["Content-Type": "application/json", "x-auth-token": UserDefaults.standard.string(forKey: "token")!]
        let dataRequest = AF.request(APIConstants.bigSaleURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseDecodable { (response: AFDataResponse<[ProductModelData]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func getOnedayItem(completion: @escaping (Result<[ProductModelData], Error>) -> Void){
        let header : HTTPHeaders = ["Content-Type": "application/json", "x-auth-token": UserDefaults.standard.string(forKey: "token")!]
        let dataRequest = AF.request(APIConstants.onedayURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseDecodable { (response: AFDataResponse<[ProductModelData]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func getEventItem(completion: @escaping (Result<[EventDataModel], Error>) -> Void){
        let header : HTTPHeaders = ["Content-Type": "application/json", "x-auth-token": UserDefaults.standard.string(forKey: "token")!]
        let dataRequest = AF.request(APIConstants.eventURL, method: .get, encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseDecodable { (response: AFDataResponse<[EventDataModel]>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
