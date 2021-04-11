//
//  PreviewTableViewCell.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-11.
//

import UIKit

class PreviewTableViewCell: UITableViewCell {

  
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var desc:UILabel!
    @IBOutlet weak var price:UILabel!
    @IBOutlet weak var discount:UILabel!
    @IBOutlet weak var sellType:UISwitch!
    @IBOutlet weak var img:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(itm :MenuItem){
        name.text=itm.name
        desc.text=itm.desc
        price.text=String(itm.price)
        discount.text=String(itm.discount)
        sellType.setOn(itm.sellType, animated: false)
        img.image=itm.image
    }
    
}
