//
//  OrderDetailsViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-13.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    var orderResult=ordersItems.first(where: {$0.ord_id == currentIndex}) as! OrderDetails
    
    @IBOutlet weak var btn_status:UIButton!
    @IBOutlet weak var lbl_time:UILabel!
    @IBOutlet weak var lbl_unit:UILabel!
    @IBOutlet weak var lbl_itemName:UILabel!
    @IBOutlet weak var lbl_price:UILabel!
    @IBOutlet weak var lbl_cusname:UILabel!
    @IBOutlet weak var lbl_ordId:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBtn()
        
        lbl_unit.text = String(orderResult.unit)
        lbl_itemName.text = orderResult.name
        lbl_price.text = String(orderResult.price)
        lbl_cusname.text = orderResult.cusName
        lbl_ordId.text = orderResult.ord_id
        switch Int(orderResult.status) {
        case 1:
           
            btn_status.setTitle("Accept", for: .normal)
            btn_status.backgroundColor = .systemGreen
            break
        case 2:
           
            btn_status.backgroundColor = .systemBlue
            btn_status.setTitle("Prepar", for: .normal)

            break
        case 4:
           
            btn_status.backgroundColor = .orange
            btn_status.setTitle("Ready", for: .normal)
            break
        case 10:
            
           
            btn_status.setTitle("Rejected", for: .normal)
            btn_status.backgroundColor = .purple
            break
        default:
            break
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func setBtn(){

        btn_status.layer.cornerRadius = 35
        btn_status.layer.borderWidth = 0
    }
    
    @IBAction func btnCall(_ sender: Any) {
        if let url = NSURL(string: "tel://\(orderResult.tel)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
        
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
