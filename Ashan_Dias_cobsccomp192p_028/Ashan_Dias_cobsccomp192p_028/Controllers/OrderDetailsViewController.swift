//
//  OrderDetailsViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-13.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var btn_status:UIButton!
    @IBOutlet weak var lbl_time:UILabel!
    @IBOutlet weak var lbl_unit:UILabel!
    @IBOutlet weak var lbl_itemName:UILabel!
    @IBOutlet weak var lbl_price:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBtn()
        // Do any additional setup after loading the view.
    }
    
    
    func setBtn(){

        btn_status.layer.cornerRadius = 35
        btn_status.layer.borderWidth = 0
       
    }
    
    @IBAction func btnCall(_ sender: Any) {
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
