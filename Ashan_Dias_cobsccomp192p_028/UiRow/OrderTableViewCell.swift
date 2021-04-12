//
//  OrderTableViewCell.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-12.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var ordid:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(order : OrderDetails) {
        name.text=order.cusName
        ordid.text=order.ord_id
    }
    
}
