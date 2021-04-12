//
//  PreviewViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-08.
//

import UIKit
import Firebase
class PreviewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
 
    
    
    private let database = Database.database().reference()
    let imageStore = Storage.storage()
    var menuItem: [MenuItem] = [
      
   ]
    
    var groupMenuItems: [GroupMenuItems] = [
    
    ]
    @IBOutlet weak var tbl_menu: UITableView!
    @IBOutlet weak var btn_cat:UIButton!
    @IBOutlet weak var btn_item:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib=UINib(nibName: "PreviewTableViewCell", bundle: nil)
        tbl_menu.register(nib, forCellReuseIdentifier: "PreviewTableViewCell")
        self.tbl_menu.delegate=self
        self.tbl_menu.dataSource=self
        btn_cat.isEnabled=false
        btn_item.isEnabled=false
    }
    
    func provideImage(index:Int,newImage:UIImage?,indexMain: Int) {
        if(newImage == nil){
            return
        }
        if(index > groupMenuItems.count){
            return // very rare index out bound exception can occur sometimes
        }
        
        groupMenuItems[indexMain].item[index].image=newImage
        tbl_menu.reloadData()
    }
    //table define
    func numberOfSections(in tableView: UITableView) -> Int {
        groupMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMenuItems[section].item.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell=tableView.dequeueReusableCell(withIdentifier: "PreviewTableViewCell", for: indexPath) as! PreviewTableViewCell
    
//        cell.setupView(itm: menuItem[indexPath.row])
        cell.setupView(itm: groupMenuItems[indexPath.section].item[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupMenuItems[section].key
    }
        
    @IBAction func clickCategory(_ sender: Any) {
        performSegue(withIdentifier: "categoryView", sender: nil)
    }
    
    @IBAction func clickMenu(_ sender: Any) {
        performSegue(withIdentifier: "menu_nav", sender: nil)
    }
    
    func loadData(){
       
        menuItem.removeAll()
        groupMenuItems.removeAll()
        
        let group = DispatchGroup()
        self.database.child("MenuItems").getData { [self] (error, snapshot) in
            if snapshot.exists() {
               
               let dataChange = snapshot.value as! [String:AnyObject]
             
               
             
               group.wait()
              
               dataChange.forEach({ (key,val) in
                
                var items = MenuItem(name: val["name"] as! String, desc: val["desc"] as! String, price: val["price"] as! Double, img: val["img"] as! String, category: val["category"] as! String, discount: val["discount"] as! Int, sellType: val["sellType"] as! Bool)

                menuItem.append(items)
                 
               })
               group.notify(queue: .main) {
                
            
                let groupByCategory = Dictionary(grouping: menuItem) { (items) -> String in
                    return items.category
                }
                
                groupByCategory.forEach({(key,val) in
                
                    groupMenuItems.append(GroupMenuItems.init(key: key, item: val))
                })
                
                
                for (indexMain,val) in groupMenuItems.enumerated() {
                 
                    for (index,item) in val.item.enumerated() {
                        self.imageStore.reference(withPath: "/\(item.img).jpg").getData(maxSize: 1 * 1024 * 1024, completion: {data,imageErr in

                            if(imageErr != nil){

                                switch StorageErrorCode(rawValue: imageErr!._code) {
                                case .objectNotFound: break
                                default:break
                                }
                            }else{
                                //if no error then update the revant cell against the index to with newly fetched food picture

                                provideImage(index: index, newImage:  UIImage(data: data!),indexMain : indexMain)

                            }
                        })
                    }
                
                }
                
                
             
                self.tbl_menu.reloadData()
                btn_cat.isEnabled=true
                btn_item.isEnabled=true
               }
              
           }
            
        }
    }
    
    private func firstDayOfMonth(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadData()
    
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
