//
//  LoginService.swift
//  moorukurly_codebase
//
//  Created by 윤예지 on 2021/06/17.
//

import Foundation
import Alamofire

struct LoginService {
    
    static let shared = LoginService()
    
    private func makeParameter(id: String, password: String) -> Parameters {
        return ["id" : id,
                "pw" : password]
    }
    
    func login(id : String,
               password : String,
               completion : @escaping (NetworkResult<Any>) -> Void) {
        
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        let dataRequest = AF.request(APIConstants.loginURL,
                                     method: .post,
                                     parameters: makeParameter(id: id, password: password),
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.pathErr)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(LoginDataModel.self, from: data) else { return .pathErr }
        
        switch statusCode {
        case 200:
            UserDefaults.standard.set(decodedData.token, forKey: "token")
            return .success(decodedData.token)
        case 400: return .requestErr(decodedData)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
