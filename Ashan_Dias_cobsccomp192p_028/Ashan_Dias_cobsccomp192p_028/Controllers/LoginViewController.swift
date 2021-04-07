//
//  ViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-06.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var button:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtn()
        // Do any additional setup after loading the view.
    }

    @IBAction func Login(_ sender: Any) {
    }
    
    @IBAction func Register(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: nil)
    }
    
    
    @IBAction func ForgetPassword(_ sender: Any) {
        performSegue(withIdentifier: "forgotpwdFromLogin", sender: nil)
    }
    
    
    func setBtn(){
       
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        
    }

}

