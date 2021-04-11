//
//  CategoryTableViewCell.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-11.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_catName:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//         Configure the view for the selected state
    }
    
    func setupView(cat : Category) {
        lbl_catName.text=cat.name
    }
    
}
