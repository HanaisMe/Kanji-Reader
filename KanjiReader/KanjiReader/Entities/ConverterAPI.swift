//
//  ConverterAPI.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - protocol ConverterAPI
protocol ConverterAPI {
    func getRubyCharacters(requestID: String?,
                           sentence: String,
                           outputType: OutputType,
                           success: @escaping (String) -> Void,
                           failure: @escaping (String) -> Void)
}

class StubbedConverterAPI: ConverterAPI {
    
    // MARK: - settings for goo lab
    
    private let domain = "https://labs.goo.ne.jp/api"
    private let appID = "" // FIXME: - please modify to your own appID
    
    enum Endpoints {
        case getRubyCharacters
    }
    
    private func getUrlString(endpoint: Endpoints) -> String {
        switch endpoint {
        case .getRubyCharacters:
            return domain + "/hiragana"
        }
    }
    
    /// convert the user input to ruby characters of a designated output type
    func getRubyCharacters(requestID: String?,
                           sentence: String,
                           outputType: OutputType,
                           success: @escaping (String) -> Void,
                           failure: @escaping (String) -> Void) {
        guard !appID.isEmpty else {
            failure("Please enter your own appID (FIXME).")
            return
        }
        let parameters = ConverterRequest(appID: appID,
                                          requestID: requestID,
                                          sentence: sentence,
                                          outputType: outputType.rawValue)
        let url = getUrlString(endpoint: .getRubyCharacters)
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    failure("The data is empty.")
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(ConverterResponse.self, from: data)
                    success(decodedResponse.converted)
                } catch {
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
