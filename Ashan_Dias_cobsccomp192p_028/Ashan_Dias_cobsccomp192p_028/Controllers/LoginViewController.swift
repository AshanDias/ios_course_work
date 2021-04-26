//
//  ViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-06.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var button:UIButton!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_pwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtn()
        // Do any additional setup after loading the view.
    }

    @IBAction func Login(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: txt_email.text!, password: txt_pwd.text!) { [weak self] authResult, error in
            guard let user = authResult?.user, error == nil else {
                self!.createAlert(title: "Error", message: error!.localizedDescription)
                print("error",error)
                return
                }
                
            self!.performSegue(withIdentifier: "loginSuccess", sender: self)
            

        }
    }
    
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Register(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: nil)
    }
    
    
    @IBAction func ForgetPassword(_ sender: Any) {
        performSegue(withIdentifier: "forgotpwdFromLogin", sender: nil)
    }
    
    
    func setBtn(){
       
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
        
    }

}

