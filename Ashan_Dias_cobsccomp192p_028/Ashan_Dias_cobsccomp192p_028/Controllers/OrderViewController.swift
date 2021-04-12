//
//  OrderViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-12.
//

import UIKit
import Firebase
class OrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    private let database = Database.database().reference()
    
    var orders: [OrderDetails] = [
      
   ]
    
    @IBOutlet weak var tbl_orders:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib=UINib(nibName: "OrderTableViewCell", bundle: nil)
        tbl_orders.register(nib, forCellReuseIdentifier: "OrderTableViewCell")
        
        tbl_orders.delegate=self
        tbl_orders.dataSource=self
        // Do any additional setup after loading the view.
    }
    
    
    func loadData(){
        let group = DispatchGroup()
        self.database.child("Orders").getData { (error, snapshot) in
             if snapshot.exists() {
                
                var dataChange = snapshot.value as! [String:AnyObject]
              
                
              
                group.wait()
                var i=0;
                var ord_id=1
              
                dataChange.values.forEach({(index) in
                    
                    var values=index as! NSArray
                    
                    
                    values.forEach({(nskey) in
                        if(i != 0){
                            var arrayData=Array(arrayLiteral: nskey)[0] as! [String:AnyObject]
                           
                            var username=arrayData["userName"] as! String

                            username=username.replacingOccurrences(of: ",", with: ".")
                           
                            var price = arrayData["price"] as! String
                                var priceVal = Double(price) as! Double
                           
                            let cart = OrderDetails(unit: arrayData["unit"] as! Int, price: priceVal , name: arrayData["item"] as! String, cusName: arrayData["userName"] as! String, ord_id: "orderRefx0\(ord_id)" as! String, status: arrayData["status"] as! Int)

                           
                            self.orders.append(cart)
                        }
                        
                        i+=1
                        ord_id+=1
                    })
                })
                

                    
                   
//
                
              
                
                group.notify(queue: .main) {
                        // do something here when loop finished
//                    self.catItems.sorted() { $0.name > $1.name }
                    self.tbl_orders.reloadData()
                }
               // print("Got data",snapshot.value!)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
    
        cell.setupView(order: orders[indexPath.row])
        return cell
    }
    
  

}
