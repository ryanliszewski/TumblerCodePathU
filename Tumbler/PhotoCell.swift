//
//  PhotoCell.swift
//  Tumbler
//
//  Created by Ryan Liszewski on 11/11/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit
import Alamofire

class PhotoCell: UITableViewCell {

  @IBOutlet weak var posterView: UIImageView!
  
  override func awakeFromNib() {
    
  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
