//
//  CellTableViewCell.swift
//  YesNote
//
//  Created by Jeff Tobin on 10/19/17.
//  Copyright © 2017 Elad. All rights reserved.
//

import UIKit

//drone table cells view
class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var droneNoteAndMuteButton: DroneNoteAndMuteButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        droneNoteAndMuteButton.layer.borderWidth = 2.0
        droneNoteAndMuteButton.layer.borderColor = UIColor(red:0.00, green:0.33, blue:0.58, alpha:1.0).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
