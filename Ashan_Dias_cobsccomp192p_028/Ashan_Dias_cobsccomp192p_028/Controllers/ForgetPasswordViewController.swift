//
//  ForgetPasswordViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-07.
//

import UIKit
import Firebase

class ForgetPasswordViewController: UIViewController {
    @IBOutlet weak var button:UIButton!
    @IBOutlet weak var txt_email: UITextField!
    let auth = Auth.auth()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtn()
        // Do any additional setup after loading the view.
    }
    
    func setBtn(){
       
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
        
    }
    
    @IBAction func Proceed(_ sender: Any) {
        if isEmpty([txt_email]){
            displayAlert(title: "Field Empty", message: "You should at least provide your email address for forget password")
        }else{
            auth.sendPasswordReset(withEmail: txt_email.text!, completion: {error in
                if error == nil{
                    self.displayAlert(title:"Message",message: "A Email is successfully submited to \(self.txt_email.text ?? "undefined")")
                }else{
                    self.alertEmailValidationErrorIfPresent(err: error!)
                }
            })
        }
//        performSegue(withIdentifier: "preceedFPWD", sender: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        performSegue(withIdentifier: "cancelForgetpwd", sender: self)
    }
    
    func displayAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
   
    
    func alertEmailValidationErrorIfPresent(err:Error){
        var message:String?
        switch AuthErrorCode(rawValue: err._code) {
        case .emailAlreadyInUse:
            message = "email is already in use.Please use another email"
        case.invalidEmail,.invalidRecipientEmail:
            message = "Invalid email address.Please enter a valid one"
        default:
            message = nil
        }
        if(message != nil){
            displayAlert(title: "Email field error", message: message!)
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
