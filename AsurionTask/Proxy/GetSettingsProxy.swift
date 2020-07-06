//
//  GetSettingsProxy.swift
//  AsurionTask
//
//  Created by Kalpesh on 27/06/20.
//  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
//

import UIKit
import Alamofire

protocol GetSettingProtocol:AnyObject {
    func getSettingSuccess(response:SettingModel)
    func getSettingFailed(error:String)
}
class GetSettingsProxy: NSObject {

    weak var delegate:GetSettingProtocol?
    func getSetting()
    {

     
        AF.request(GET_SETTING, method: .get,headers: ["secret-key":SECRETE_KEY])
            .responseDecodable(of: SettingModel.self) { (response) in
                switch response.result {
                case .success(let value):
                    self.delegate?.getSettingSuccess(response: value)
                    print(value)

                case .failure(let error): break
                    // error handling
                self.delegate?.getSettingFailed(error: error.localizedDescription)


                }
        }

    }
}
