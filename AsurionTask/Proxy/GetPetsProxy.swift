//
//  GetPetsProxy.swift
//  AsurionTask
//
//  Created by Kalpesh on 27/06/20.
//  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
//

import UIKit
import Alamofire

protocol GetPetsProxyProtocol:AnyObject {
    func getPetsSuccess(response:[PetModel])
    func getPetFailed(error:String)
}
class GetPetsProxy: NSObject {
    weak var delegate:GetPetsProxyProtocol?
    func getPetsList()
      {

          AF.request(GET_PETS, method: .get,headers: ["secret-key":SECRETE_KEY])
              .responseDecodable(of: PetModels.self) { (response) in
                  switch response.result {
                  case .success(let value):

                    
                    self.delegate?.getPetsSuccess(response: value.all)
                    print(value)

                  case .failure(let error): break
                      // error handling
                  self.delegate?.getPetFailed(error: error.localizedDescription)


                  }
          }

      }
}
