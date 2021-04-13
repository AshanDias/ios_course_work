//
//  OrderTableViewCell.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-12.
//

import UIKit
import Firebase

class OrderTableViewCell: UITableViewCell {
    private let database = Database.database().reference()
    
    
    
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var ordid:UILabel!
    @IBOutlet weak var btn_rj:UIButton!
    @IBOutlet weak var btn_a_s:UIButton!
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
        setBtn()
    }
    
    func setBtn(){
       
        btn_rj.layer.cornerRadius = 24
        btn_rj.layer.borderWidth = 0
        btn_a_s.layer.cornerRadius = 24
        btn_a_s.layer.borderWidth = 0
    }
    
    @IBAction func btnAccept(_ sender: Any) {
        var ordRes = ordersItems.first(where: { $0.ord_id == ordid.text}) as! OrderDetails
        ordRes.status = 2
        self.database.child("OrderItems").child(ordid.text!).setValue(ordRes.getJSON())
       
    }
    
}
