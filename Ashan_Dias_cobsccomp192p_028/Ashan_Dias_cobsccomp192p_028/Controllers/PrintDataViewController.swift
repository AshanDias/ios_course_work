//
//  PrintDataViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-14.
//

import UIKit
import Firebase

class PrintDataViewController: UIViewController {

    private let database = Database.database().reference()
    
    var ordersItems: [OrderDetails] = [
      
    ]
    @IBOutlet weak var tbl_print:UITableView!
    
    @IBOutlet weak var dp1: UIDatePicker!
    @IBOutlet weak var dp2: UIDatePicker!
    @IBOutlet weak var lbl_value: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib=UINib(nibName: "PrintTableViewCell", bundle: nil)
        tbl_print.register(nib, forCellReuseIdentifier: "PrintTableViewCell")
        tbl_print.delegate=self
        tbl_print.dataSource=self
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        
        let group = DispatchGroup()
        self.database.child("OrderItems").getData { (error, snapshot) in
            if snapshot.exists() {
                
                var dataChange = snapshot.value as! [String:AnyObject]
                
                  group.wait()
                
                dataChange.forEach({ (key,val) in
                    var data=OrderDetails(unit: val["unit"] as! Int, price: val["price"] as! Double, name: val["name"] as! String, cusName: val["cusName"] as! String, ord_id: val["ord_id"] as! String, status: val["status"] as! Int as! Int, tel: val["tel"] as! Int, date: val["date"] as! String)
                   
                    self.ordersItems.append(data)
                    
                })
            }
           
            
            
            group.notify(queue: .main) { [self] in
                
                 tbl_print.reloadData()
//                refreshControl?.endRefreshing()
//                print(ordersItems)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    @IBAction func btnProcess(_ sender: Any) {
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


extension PrintDataViewController:UITableViewDelegate,UITableViewDataSource{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "PrintTableViewCell", for: indexPath) as! PrintTableViewCell
     
        cell.setupView(order: ordersItems[indexPath.row])
        print(cell.lbl_item.text)
        return cell
    }
    
    
}
