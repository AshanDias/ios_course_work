//
//  PrintViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-14.
//

import UIKit
import Firebase

class PrintViewController:UIViewController{
   

    private let database = Database.database().reference()
    
    var ordersItems: [OrderDetails] = [
      
    ]
//    var refreshControl: UIRefreshControl?
  
    override func viewDidLoad() {
        super.viewDidLoad()
     
      
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
//
//     func refreshData(){
//         refreshControl = UIRefreshControl()
//                refreshControl?.tintColor = UIColor.red
//         refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
//                tbl_print.addSubview(refreshControl!)
//
//     }
//
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
                
//                 tbl_print.reloadData()
//                refreshControl?.endRefreshing()
                print(ordersItems)
            }
        }
    }
    

   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return ordersItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "PrintTableViewCell", for: indexPath) as! PrintTableViewCell
     
        cell.setupView(order: ordersItems[indexPath.row])
        print(cell)
        return cell
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
