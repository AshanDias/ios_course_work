//
//  PreviewViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-08.
//

import UIKit
import Firebase
class PreviewViewController: UIViewController {
    
    private let database = Database.database().reference()
    
    var menuItem: [MenuItem] = [
      
   ]
    @IBOutlet weak var tbl_menu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib=UINib(nibName: "PreviewTableViewCell", bundle: nil)
        tbl_menu.register(nib, forCellReuseIdentifier: "PreviewTableViewCell")
        self.tbl_menu.delegate=self
        self.tbl_menu.dataSource=self
//        loadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickCategory(_ sender: Any) {
        performSegue(withIdentifier: "categoryView", sender: nil)
    }
    
    @IBAction func clickMenu(_ sender: Any) {
        performSegue(withIdentifier: "menu_nav", sender: nil)
    }
    func loadData(){
        let group = DispatchGroup()
        self.database.child("MenuItems").getData { (error, snapshot) in
            if snapshot.exists() {
               
               let dataChange = snapshot.value as! [String:AnyObject]
             
               
             
               group.wait()
              
               dataChange.forEach({ (key,val) in
                
                let items = MenuItem(name: val["name"] as! String, desc: val["desc"] as! String, price: val["price"] as! Double, img: val["img"] as! String, category: val["category"] as! String, discount: val["discount"] as! Int, sellType: val["sellType"] as! Bool)
//
//
                   self.menuItem.append(items)
                 
               })
               
             
               
               group.notify(queue: .main) {
                       // do something here when loop finished
//                   self.catItems.sorted() { $0.name > $1.name }
//                   self.tbl_category.reloadData()
                self.tbl_menu.reloadData()
               }
              // print("Got data",snapshot.value!)
           }
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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

extension PreviewViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "PreviewTableViewCell", for: indexPath) as! PreviewTableViewCell
     
        cell.setupView(itm: menuItem[indexPath.row])
      
        return cell
    }
    
    
}
