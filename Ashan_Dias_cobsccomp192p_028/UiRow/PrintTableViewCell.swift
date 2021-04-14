//
//  PrintTableViewCell.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-14.
//

import UIKit

class PrintTableViewCell: UITableViewCell {

    @IBOutlet weak var  lbl_item:UILabel!
    @IBOutlet weak var lbl_price:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupView(order : OrderDetails) {
       
        lbl_item.text = order.name
        lbl_price.text = String(order.price)
        
    }
    
}
