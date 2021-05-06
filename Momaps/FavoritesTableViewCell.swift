//
//  FavoritesTableViewCell.swift
//  Momaps
//
//  Created by Cosmo on 5/6/21.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
