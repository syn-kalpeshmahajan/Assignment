//
//  SettingModel.swift
//  AsurionTask
//
//  Created by Kalpesh on 27/06/20.
//  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
//

import UIKit

struct SettingModel: Decodable {
  var isChatEnabled: Bool
  var isCallEnabled: Bool
  let workHours: String


  enum CodingKeys: String, CodingKey {
    case isChatEnabled
    case isCallEnabled 
    case workHours

  }
}
