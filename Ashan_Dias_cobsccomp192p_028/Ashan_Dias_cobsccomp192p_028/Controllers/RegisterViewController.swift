//
//  RegisterViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-07.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var button:UIButton!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_pwd: UITextField!
    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var confirmpwd: UITextField!
    let auth = Auth.auth()
    let authService = AuthService()
    private let db = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_email.autocorrectionType = .no
        setBtn()
        // Do any additional setup after loading the view.
    }
    
    func setBtn(){
       
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
        
    }

    func displayAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
     
    
    @IBAction func Login(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: nil)
    }
    
    @IBAction func ForgotPassword(_ sender: Any) {
        performSegue(withIdentifier: "forgotpwdFromRegister", sender: nil)
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        
        let result1 = authService.validateEmail(email: txt_email.text!)
           let result2 = authService.isValidPassword(pwd: txt_pwd.text!)
        
        if(isEmpty([txt_email,txt_pwd,txt_phone,confirmpwd])){
            displayAlert(title:"Field Error",message: "Some fields are emptyty!")
        }else{
            if(txt_pwd.text != confirmpwd.text){
                displayAlert(title:"Field mismatch",message: "confirmation password doesn't match!")
            }else{
                
                //start
                
            if(result1 && result2){
                    
                
                    
                auth.createUser(withEmail: txt_email.text!, password: txt_pwd.text!, completion: ({result,err in
                    if(err == nil){
                        /*
                         if no error then user can proceed to register the account.Upon registering the the database will create
                         a docuemnt in 'orders' and 'user' collection with intitial data...
                         */
                        
                        self.db.child("user/\(result!.user.uid)").setValue(["phoneNumber":self.txt_phone.text!])
                        
                        self.performSegue(withIdentifier: "successRegister", sender: self)
                        
                    }else{
                      
                         var message:String
                        switch AuthErrorCode(rawValue: err!._code) {
                           case .networkError:
                               message = "Something went wrong with connection.Try again later"
                           case .weakPassword:
                               message = "passowrd is too weak"
                           default:
                               message = "unknown error had occured"
                           }
                        self.displayAlert(title: "User registration failed", message: message)
                       
                        
                    }
                    
                    
                }))
            }else{
                displayAlert(title: "User registration failed", message: "Email or password badly formatted!")
            }
                
                //end
                
               
            }
        }
    }
    
    func isEmpty(_ fields:[UITextField]) -> Bool {
        //utility function is check if the field is empty
        for field in fields{
            if field.text == nil || field.text!.count == 0{
                return true
            }
        }
        return false
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
