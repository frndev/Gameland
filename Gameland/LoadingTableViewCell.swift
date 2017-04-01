//
//  LoadingTableViewCell.swift
//  Gameland
//
//  Created by fran on 1/4/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var searchLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.activityIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
