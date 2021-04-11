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
    
    func provideImage(index:Int,newImage:UIImage?) {
        if(newImage == nil){
            return
        }
        if(index > menuItem.count){
            return // very rare index out bound exception can occur sometimes
        }
        menuItem[index].image = newImage

        let indexPath = IndexPath(item: index, section: 0)
        tbl_menu.reloadRows(at: [indexPath], with: .top)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuItem.count
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell=tableView.dequeueReusableCell(withIdentifier: "PreviewTableViewCell", for: indexPath) as! PreviewTableViewCell
    
            cell.setupView(itm: menuItem[indexPath.row])
    
            return cell
        }
        
    @IBAction func clickCategory(_ sender: Any) {
        performSegue(withIdentifier: "categoryView", sender: nil)
    }
    
    @IBAction func clickMenu(_ sender: Any) {
        performSegue(withIdentifier: "menu_nav", sender: nil)
    }
    
    func loadData(){
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
               
                for (index,item) in menuItem.enumerated() {
                    self.imageStore.reference(withPath: "/\(item.img).jpg").getData(maxSize: 1 * 1024 * 1024, completion: {data,imageErr in

                        if(imageErr != nil){

                            switch StorageErrorCode(rawValue: imageErr!._code) {
                            case .objectNotFound: break
                                //if the image is not available in the database then display a default image
                               // self.menuItem.i(index: index, newImage: #imageLiteral(resourceName: "foodDefault"))
                            default:break
                            }
                        }else{
                            //if no error then update the revant cell against the index to with newly fetched food picture
                          
                          provideImage(index: index, newImage:  UIImage(data: data!))
                           
                        }
                    })
                }
            
                    
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
