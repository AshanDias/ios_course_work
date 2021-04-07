//
//  ViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-06.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var button:UIButton!
    @IBOutlet weak var register:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtn()
        // Do any additional setup after loading the view.
    }

    @IBAction func Login(_ sender: Any) {
    }
    
    
    func setBtn(){
       
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        
    }

}

