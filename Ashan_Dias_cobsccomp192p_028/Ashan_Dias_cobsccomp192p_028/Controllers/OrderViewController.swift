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
    var grouporders: [GroupOrders] = [
    
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
                           
                            var cart = OrderDetails(unit: arrayData["unit"] as! Int, price: priceVal , name: arrayData["item"] as! String, cusName: username, ord_id: "orderRefx0\(ord_id)" as! String, status: arrayData["status"] as! Int)
                            
                            var number = Int.random(in: 0..<60)
                            cart.randNo = number
                            self.orders.append(cart)
                            self.database.child("OrderItems").child(String(ord_id)).setValue(cart.getJSON())
                            ord_id+=1
                        }
                        
                        i+=1
                        
                    })
                })
                

                    
                   
//
                
              
                
                group.notify(queue: .main) {
                 
                    let groupByOrders = Dictionary(grouping: self.orders) { (items) -> Int in
                        return items.status
                    }
                    
                    groupByOrders.forEach({(key,val) in
                   
                        
                        self.grouporders.append(GroupOrders.init(status: key, orders: val))
                    })
                    
                  
                    
                    self.tbl_orders.reloadData()
                }
               
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        grouporders.count
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grouporders[section].orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
    
        cell.setupView(order: grouporders[indexPath.section].orders[indexPath.row])
//        cell.setupView(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var status=grouporders[section].status
       
        if(status == 1){
            return "New"
        }else {
            return "Ready"
        }
       
    }
    
  

}
