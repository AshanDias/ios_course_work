//
//  ForgetPasswordViewController.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-07.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    @IBOutlet weak var button:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtn()
        // Do any additional setup after loading the view.
    }
    
    func setBtn(){
       
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        
    }
    
    @IBAction func Proceed(_ sender: Any) {
        performSegue(withIdentifier: "preceedFPWD", sender: nil)
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
