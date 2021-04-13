//
//  OrderViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-12.
//

import UIKit
import Firebase

var orders: [OrderDetails] = [
  
]
class OrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    private let database = Database.database().reference()
    
    var ordersItems: [OrderDetails] = [
      
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
        
        orders.removeAll()
        grouporders.removeAll()
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
                           var orderId="orderRefx0\(ord_id)"
                            var price = arrayData["price"] as! String
                                var priceVal = Double(price) as! Double
                           
                            var cart = OrderDetails(unit: arrayData["unit"] as! Int, price: priceVal , name: arrayData["item"] as! String, cusName: username, ord_id: orderId as! String, status: arrayData["status"] as! Int)
                            
//                            var number = Int.random(in: 0..<60)
//                            cart.randNo = number
                            orders.append(cart)
                            
//                            self.database.child("OrderItems").child(String(orderId)).setValue(cart.getJSON())
                            ord_id+=1
                        }
                        
                        i+=1
                        
                    })
                })
                

                    
                   
//
                
              
                
                group.notify(queue: .main) {
                 
                    let groupByOrders = Dictionary(grouping: orders) { (items) -> Int in
                        return items.status
                    }
                    
                    groupByOrders.forEach({(key,val) in
                   
                        
                        self.grouporders.append(GroupOrders.init(status: key, orders: val))
                    })
                    
                    self.tbl_orders.reloadData()
                    //fetch data
                    
                    let group2 = DispatchGroup()
                    self.database.child("OrderItems").getData { (error, snapshot) in
                        if snapshot.exists() {
                            var dataChange = snapshot.value as! [String:AnyObject]
                            group2.wait()
                            dataChange.forEach({(key,arrayData) in
//
                                var data=OrderDetails(unit: arrayData["unit"] as! Int, price: arrayData["price"] as! Double , name: arrayData["name"] as! String, cusName: arrayData["cusName"] as! String, ord_id: arrayData["ord_id"] as! String, status: arrayData["status"] as! Int)
                                
                                self.ordersItems.append(data)
//
                               
                                
                            })
                            
                            group2.notify(queue: .main){
                                var i=0;
                                //compare
                                for itme in orders{
                                    
                                    if(orders[i].ord_id == self.ordersItems[i].ord_id){
                                        print("eq")
                                    }else{
                                        print("neq")
                                    }
                                    i+=1
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                   
                   
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
    
       
        if(grouporders.count > 0){
            cell.setupView(order: grouporders[indexPath.section].orders[indexPath.row])
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var status=1
        if(grouporders.count > 0){
            status=grouporders[section].status
        }
    
       
        if(status == 1){
            return "New"
        }else {
            return "Ready"
        }
       
    }
    
  

}
