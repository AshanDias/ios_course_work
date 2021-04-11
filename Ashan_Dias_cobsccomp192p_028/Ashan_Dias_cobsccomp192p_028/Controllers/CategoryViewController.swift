//
//  CategoryViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-08.
//

import UIKit
import Firebase
class CategoryViewController: UIViewController {

    private let database = Database.database().reference()
    var catItems: [Category] = [
      
   ]
    
    @IBOutlet weak var tbl_category: UITableView!
    @IBOutlet weak var button:UIButton!
    @IBOutlet weak var txt_name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtn()
        let nib=UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tbl_category.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")
        self.tbl_category.delegate=self
        self.tbl_category.dataSource=self
        loadData()
        // Do any additional setup after loading the view.
    }
    func setBtn(){
       
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
        
    }
    
    
    @IBAction func AddCategory(_ sender: Any) {
      
        
            let cat=Category(name: txt_name.text)
          //  catItems.append(cat)
            let child=UUID().uuidString
            self.database.child("Category").child(child).setValue(txt_name.text)
            //self.tbl_category.reloadData()
        
       loadData()
        
    }
    
    func loadData(){
        let group = DispatchGroup()
        self.database.child("Category").getData { (error, snapshot) in
             if snapshot.exists() {
                
                let dataChange = snapshot.value as! [String:AnyObject]
              
                
              
                group.wait()
               
                dataChange.forEach({ (key,val) in
                  
                    let cart = Category(name: val as! String,id: key as! String)
                    
                
                    self.catItems.append(cart)
                  
                })
                
              
                
                group.notify(queue: .main) {
                        // do something here when loop finished
                    self.catItems.sorted() { $0.name > $1.name }
                    self.tbl_category.reloadData()
                }
               // print("Got data",snapshot.value!)
            }
        }
        
    }

}

extension CategoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
     
        cell.setupView(cat: catItems[indexPath.row])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
        if editingStyle == .delete {
           
            let id=catItems[indexPath.row].id!
            self.database.child("Category").child(id).removeValue()
            catItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
           }
        
        
    }
    
    
}
