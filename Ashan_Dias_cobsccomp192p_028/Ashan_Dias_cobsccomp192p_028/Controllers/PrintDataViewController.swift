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
    var refreshControl: UIRefreshControl?
    var ordersItems: [OrderDetails] = [
      
    ]
    var result: [OrderDetails] = []
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
        loadData()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func loadData(){
        ordersItems.removeAll()
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
                    setValue()
                
            }
        }
    }
    
    func setValue(){
        var total=0.00
        for itm in ordersItems{
            total += itm.price
        }
        lbl_value.text = String(total)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        loadData()
    }
    
    @IBAction func btnProcess(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        var d1=dateFormatter.string(from: dp1.date)
        if(ordersItems.count==0 && ordersItems.count==0){
            loadData()
            dp1.date=Date()
        }
        result.removeAll()
        for itmes in ordersItems{
            
         
            let substring = d1.dropFirst(1)
            let realString1 = String(substring)
            var date=String(itmes.date!)
            
            if(date == realString1){
                result.append(itmes)
                }
           
           
        }

        ordersItems.removeAll()
       
        
        for data in result {
            ordersItems.append(data)
        }
        
        
        tbl_print.reloadData()
        setValue()
       
    }
    
    func printText(text:String){
            let printInfo = UIPrintInfo(dictionary:nil)
            printInfo.outputType = UIPrintInfo.OutputType.grayscale
            printInfo.jobName = "Order Details"
            printInfo.orientation = .portrait

            let printController = UIPrintInteractionController.shared
            printController.printInfo = printInfo
            printController.showsNumberOfCopies = false
                
            let formatter = UIMarkupTextPrintFormatter(markupText: text)
            //formatter.contentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
            printController.printFormatter = formatter
            
            printController.present(animated: true, completionHandler: nil)
        }




    @IBAction func btnPrint(_ sender: Any) {
        
        var markuptext=""
       

        
        for item in ordersItems{
            markuptext += "<tr> <td> \(String(item.unit)) </td> <td> \(String(item.name)) </td> <td> \(String(item.price)) </td> </tr>"
                
        }
        
        var temp="<center><table><tr><th>Unit</th><th>Name</th><th>Price</th></tr>\(markuptext)</table></center>"
      
        printText(text: temp)
        
    }
    
    
  

}


extension PrintDataViewController:UITableViewDelegate,UITableViewDataSource{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return ordersItems.count
        if ordersItems.count == 0 {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
                   messageLabel.text = "No records found !"
                   messageLabel.textColor = .black
                   messageLabel.numberOfLines = 0
                   messageLabel.textAlignment = .center
                   messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
                   messageLabel.sizeToFit()

            tbl_print.backgroundView = messageLabel
        }else{
            tbl_print.backgroundView = nil
        }

        return ordersItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "PrintTableViewCell", for: indexPath) as! PrintTableViewCell
     
        cell.setupView(order: ordersItems[indexPath.row])
       
        return cell
    }
    
    
}
