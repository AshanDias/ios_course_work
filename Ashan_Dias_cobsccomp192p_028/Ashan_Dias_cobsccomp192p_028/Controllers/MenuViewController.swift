//
//  MenuViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-08.
//

import UIKit
import iOSDropDown
import Firebase
class MenuViewController: UIViewController {
    
    private let database = Database.database().reference()
    
    @IBOutlet weak var button:UIButton!
    @IBOutlet weak var dropDown : DropDown!
    @IBOutlet weak var name :UITextField!
    @IBOutlet weak var desc :UITextField!
    @IBOutlet weak var price :UITextField!
    @IBOutlet weak var discount :UITextField!
    @IBOutlet weak var sellType :UISwitch!
    var catSelectedItem = ""
    var imageId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        button.isEnabled=false
        setBtn()
        loadDropDown()
        // Do any additional setup after loading the view.
    }
    
    func setBtn(){
       
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
        
    }
    
    func loadDropDown(){
        let group = DispatchGroup()
        self.database.child("Category").getData { (error, snapshot) in
            if snapshot.exists(){
                let dataChange = snapshot.value as! [String:AnyObject]
                group.wait()
               
                dataChange.forEach({ (key,val) in
                  
                    
                    self.dropDown.optionArray.append(val as! String)
                    
                  
                })
                
                group.notify(queue: .main) {
                        // do something here when loop finished
                    self.button.isEnabled=true
                    self.dropDown.didSelect{(selectedText , index ,id) in
                        self.catSelectedItem=selectedText
                    }
                }
            }
        }
    }
     
    @IBAction func btnAdd(_ sender: Any) {
       
        
        let menu=MenuItem(name: name.text!, desc: desc.text!, price: Double(price.text!)!, img: imageId, category: catSelectedItem, discount: Int(discount.text!)!, sellType: sellType.isOn)
        
            let child = Int.random(in: 0...1000)
        self.database.child("MenuItems").child(String(child)).setValue(menu.getJSON())
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
