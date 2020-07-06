//
//  PetModel.swift
//  AsurionTask
//
//  Created by Kalpesh on 27/06/20.
//  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
//

import UIKit

struct PetModel: Decodable {
  let imageUrl: String
  let title: String
  let contentUrl: String
let dateAdded: String


  enum CodingKeys: String, CodingKey {
    case imageUrl = "image_url"
    case title
    case contentUrl = "content_url"
    case dateAdded = "date_added"

  }
}

struct PetModels: Decodable {
  let all: [PetModel]

  enum CodingKeys: String, CodingKey {
    case all = "results"
  }
}
