//
//  PetTableViewCell.swift
//  AsurionTask
//
//  Created by Kalpesh on 27/06/20.
//  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
//

import UIKit

class PetTableViewCell: UITableViewCell {

    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    var imageLoader = ImageDownloader()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(model:PetModel)
    {
        labelTitle.text = model.title

        imageLoader.obtainImageWithPath(imagePath: model.imageUrl) { (image) in

            self.imageVIew.image = image

        }
    }

}
