//
//  GalleryTableViewCell.swift
//  PhotoGalleryApp
//
//  Created by Prachi Bile on 01/06/21.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet var galleryImageView: UIImageView!
    @IBOutlet var galleryImageNameLbl: UILabel!
    @IBOutlet weak var dateOfImageTaken: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
