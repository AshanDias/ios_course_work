//
//  OrderViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-12.
//

import UIKit
import Firebase
import CoreLocation
import AVFoundation

var currentIndex=""
var orders: [OrderDetails] = [
  
]
var ordersItems: [OrderDetails] = [
  
]
let cache = NSCache<NSString, NSArray>()

class OrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{
    private let database = Database.database().reference()

    let locationManager = CLLocationManager()
    var player: AVAudioPlayer?
//   var locationSercice=LocationService()
    var refreshControl: UIRefreshControl?
  
    var grouporders: [GroupOrders] = [
    
    ]
    
    var lt=0.00
    var lat=0.00
    @IBOutlet weak var tbl_orders:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
               locationManager.requestWhenInUseAuthorization()
               if CLLocationManager.locationServicesEnabled() {
                   locationManager.delegate = self
                locationManager.desiredAccuracy = 1
                   locationManager.startUpdatingLocation()
               }
        
        let nib=UINib(nibName: "OrderTableViewCell", bundle: nil)
        tbl_orders.register(nib, forCellReuseIdentifier: "OrderTableViewCell")
       
        tbl_orders.delegate=self
        tbl_orders.dataSource=self
    
//        tbl_orders.refreshControl?.beginRefreshing()
        refreshData()
        loadData()
       
      
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.lt=0.00
        self.lat=0.00
        self.lt=locValue.longitude
        self.lat=locValue.latitude
        }
    
    
    
    
    func playSound() {
            let pathToSound = Bundle.main.path(forResource: "notification", ofType: "mp3")!
            let url = URL(fileURLWithPath: pathToSound)
            do {
               // try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                //try AVAudioSession.sharedInstance().setActive(true)
                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
               // let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                /* iOS 10 and earlier require the following line:*/
               
                player = try AVAudioPlayer(contentsOf: url)
                player!.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }


    
    func calculateDistance(lt:Double,lat:Double) -> Int{
     
        let longt = Double(self.lt)
        let lattude = Double(self.lat)
        
//        let longt1 = Double(37.59452644)
//        let lattude1 = Double(-122.41234263)
        
        
        let coordinate1 = CLLocation(latitude: lat, longitude: lt)
        let coordinate2 = CLLocation(latitude: lattude, longitude:longt)
        let distanceInMeters = coordinate2.distance(from: coordinate1)/1000
        return Int(distanceInMeters)
    }

    
   
    func refreshData(){
        refreshControl = UIRefreshControl()
               refreshControl?.tintColor = UIColor.red
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
               tbl_orders.addSubview(refreshControl!)
       
    }
    
    
    @objc func loadData(){
        
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
//        let cacheData = cache.object(forKey: "grouporders")
     
            orders.removeAll()
            grouporders.removeAll()
    //        ordersItems.removeAll()
            let group = DispatchGroup()
            self.database.child("Orders").getData { (error, snapshot) in
                 if snapshot.exists() {
                    
                    let dataChange = snapshot.value as! [String:AnyObject]
                  
                    
                  
                    group.wait()
                    var i=0;
                    var ord_id=1
                  
                    dataChange.values.forEach({(index) in
                        
                        let values=index as! NSArray
                        
                        
                        values.forEach({(nskey) in
                            if(i != 0){
                                let arrayData=Array(arrayLiteral: nskey)[0] as! [String:AnyObject]
                               
                                var username=arrayData["userName"] as! String

                                username=username.replacingOccurrences(of: ",", with: ".")
                                let orderId="orderRefx0\(ord_id)"
                                let price = arrayData["price"] as! String
                                let priceVal = Double(price)!
                               
                                let cart = OrderDetails(unit: arrayData["unit"] as! Int, price: priceVal , name: arrayData["item"] as? String, cusName: username, ord_id: orderId , status: arrayData["status"] as? Int,tel: arrayData["tel"] as? Int,date: arrayData["date"] as? String,longtude: arrayData["longtude"] as? Double, latitude: arrayData["latitude"] as? Double)
                                
                           
                                orders.append(cart)
                                
                               
                                ord_id+=1
                            }
                            
                            i+=1
                            
                        })
                    })
                    

                        
                       
    //
                    
                  
                    
                    group.notify(queue: .main) { [self] in
                     
                      
                      
                        //fetch data
                     
                        let group2 = DispatchGroup()
                        self.database.child("OrderItems").getData { (error, snapshot) in
                            if snapshot.exists() {
                                let dataChange = snapshot.value as! [String:AnyObject]
                                group2.wait()
                                ordersItems.removeAll()
                                dataChange.forEach({(key,arrayData) in
                                    let distance =  calculateDistance(lt: arrayData["longtude"] as! Double, lat: arrayData["latitude"] as! Double)
                                    
                                    

                                                        let st = arrayData["status"] as! Int
                                                                       
                                                                       if(distance < 4 && st == 4){

                                                                        let data=OrderDetails(unit: arrayData["unit"] as! Int, price: arrayData["price"] as! Double , name: arrayData["name"] as? String, cusName: arrayData["cusName"] as! String, ord_id: arrayData["ord_id"] as! String, status: 5,tel: arrayData["tel"] as? Int,date: arrayData["date"] as? String,longtude: arrayData["longtude"] as? Double, latitude: arrayData["latitude"] as? Double)
                                                                           ordersItems.append(data)
                                                                        playSound()

                                                                       }else{

                                                                        let data=OrderDetails(unit: arrayData["unit"] as! Int, price: arrayData["price"] as! Double , name: arrayData["name"] as? String, cusName: arrayData["cusName"] as! String, ord_id: arrayData["ord_id"] as! String, status: arrayData["status"] as? Int,tel: arrayData["tel"] as? Int,date: arrayData["date"] as? String,longtude: arrayData["longtude"] as? Double, latitude: arrayData["latitude"] as? Double)
                                                                           ordersItems.append(data)
                                                                       }
                                    




    
                                   
                                
                                })
                                
                                group2.notify(queue: .main){ [self] in
                                   
    //                                cartItems.first(where:{ $0.item == lbl_item.text})
                                    for item in orders{
                                        
                                        let res = ordersItems.first(where: {$0.ord_id == item.ord_id})?.ord_id
                                       
                                        if(res==nil){
                                           
                                          
                                        
                                            let distance =  calculateDistance(lt: item.longtude, lat: item.latitude)
                                                                                      if(distance < 4 && item.status == 4){
                                                                                        let orderData = OrderDetails(unit: item.unit, price: item.price, name: item.name, cusName: item.cusName, ord_id: item.ord_id, status: 5,tel: item.tel,date: formatter1.string(from: today),longtude: item.longtude,latitude: item.latitude)
                                                                                          self.database.child("OrderItems").child(String(item.ord_id)).setValue(orderData.getJSON())
                                                                                        
                                                                                        playSound()
                                                                                      }
                                                                                      else{
                                                                                        let orderData = OrderDetails(unit: item.unit, price: item.price, name: item.name, cusName: item.cusName, ord_id: item.ord_id, status: item.status,tel: item.tel,date: formatter1.string(from: today),longtude: item.longtude,latitude: item.latitude)
                                                                                          
                                                                                              self.database.child("OrderItems").child(String(item.ord_id)).setValue(orderData.getJSON())
                                                                                          
                                                                                      }

                                            
                                        }
                                    }
                                   
                                    let groupByOrders = Dictionary(grouping: ordersItems) { (items) -> Int in
                                        return items.status
                                    }
                                    
                                    groupByOrders.forEach({(key,val) in
                                   
                                        
                                        self.grouporders.append(GroupOrders.init(status: key, orders: val))
                                    })
                                   
                                   // cache.setObject(grouporders as NSArray, forKey: "grouporders")
                                       
                                    
                                   
                                        self.tbl_orders.reloadData()
                                   // refreshControl?.endRefreshing()
                                }
                                
                            }else{
                                if(orders.count > 0){
                                    
                                    
                                    for item in orders{
                                        
                                        let res = ordersItems.first(where: {$0.ord_id == item.ord_id})?.ord_id
                                       
                                        if(res==nil){
                                            
                                         
                                            let distance = calculateDistance(lt: item.longtude, lat: item.latitude)
                                              if(distance < 4 && item.status == 4){
                                                let orderData = OrderDetails(unit: item.unit, price: item.price, name: item.name, cusName: item.cusName, ord_id: item.ord_id, status: 5,tel: item.tel,date: formatter1.string(from: today),longtude: item.longtude,latitude: item.latitude)
                                                  self.database.child("OrderItems").child(String(item.ord_id)).setValue(orderData.getJSON())
                                                
                                                playSound()
                                              }
                                              else{
                                                let orderData = OrderDetails(unit: item.unit, price: item.price, name: item.name, cusName: item.cusName, ord_id: item.ord_id, status: item.status,tel: item.tel,date: formatter1.string(from: today),longtude: item.longtude,latitude: item.latitude)
                                                  
                                                      self.database.child("OrderItems").child(String(item.ord_id)).setValue(orderData.getJSON())
                                                  
                                              }
                                            
                                           

                                        }
                                    }
                                    
                                   
                                }else{
                                    ordersItems.removeAll()
                                  
                                }
                               
                        
                            }
                            
                            
                        }
                        
                        self.tbl_orders.reloadData()
                        refreshControl?.endRefreshing()
                        
                    }
                   
                }
            }
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        loadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return grouporders.count
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       
        return grouporders[section].orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
       
        let cell=tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        

        
       
        if(grouporders.count > 0){
            cell.setupView(order: grouporders[indexPath.section].orders[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        currentIndex =  grouporders[indexPath.section].orders[indexPath.row].ord_id

            performSegue(withIdentifier: "orderDetails", sender: nil)


    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var status=1
        if(grouporders.count > 0){
            status=grouporders[section].status
        }
    
        if(status == 1){
            return "New"
        }
        else if(status == 2){
            return "Pending"
        }
        else if(status == 4){
            return "Ready"
        }
        else if(status == 10){
            return "Cancelled"
        }else if(status == 5){
            return "Arriving"
        }
        else {
            return ""
        }
       
    }
    
    
   
    
    
  

}
