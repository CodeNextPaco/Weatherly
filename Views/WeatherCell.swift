//
//  WeatherCell.swift
//  Weatherly
//
//  Created by admin on 6/25/22.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var cellTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
