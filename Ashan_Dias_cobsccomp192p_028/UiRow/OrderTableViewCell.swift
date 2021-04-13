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
        
        //status
        // 1= acept or reject
        // 2 = accepted
        // 3 reject
        // 4 = ready
        //5 = arriving

        var status=Int(order.status!)

        
        
        switch Int(order.status) {
        case 1:
            btn_rj.isHidden=false
            btn_a_s.setTitle("Accept", for: .normal)
            btn_a_s.backgroundColor = .systemGreen
            break
        case 2:
            btn_rj.isHidden=true
            btn_a_s.backgroundColor = .systemBlue
            btn_a_s.setTitle("Prepar", for: .normal)

            break
        case 4:
            btn_rj.isHidden=true
            btn_a_s.backgroundColor = .orange
            btn_a_s.setTitle("Ready", for: .normal)
            break
        case 10:
            
            btn_rj.isHidden=true
            btn_a_s.isEnabled=false
            btn_a_s.setTitle("Rejected", for: .normal)
            btn_a_s.backgroundColor = .purple
            break
        default:
            break
        }
       
    }
    
    func setBtn(){
       
        btn_rj.layer.cornerRadius = 24
        btn_rj.layer.borderWidth = 0
        btn_a_s.layer.cornerRadius = 24
        btn_a_s.layer.borderWidth = 0
    }
    
    @IBAction func btnAccept(_ sender: Any) {
        var ordRes = ordersItems.first(where: { $0.ord_id == ordid.text}) as! OrderDetails
        
       
        switch ordRes.status {
        case 1:
            
            ordRes.status = 2
           break
        case 2:
            ordRes.status = 4 //4 is ready status
            break
            
        default:
            break
        }
        
        
        self.database.child("OrderItems").child(ordid.text!).setValue(ordRes.getJSON())
     
    }
    
    @IBAction func btnReject(_ sender: Any) {
        var ordRes = ordersItems.first(where: { $0.ord_id == ordid.text}) as! OrderDetails
      
        switch ordRes.status {
        case 1:
            
            ordRes.status = 10
           break
       
        default:
            break
        }
        
        
        self.database.child("OrderItems").child(ordid.text!).setValue(ordRes.getJSON())
    }
}
