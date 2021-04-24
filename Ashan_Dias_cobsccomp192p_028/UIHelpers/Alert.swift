//
//  Alert.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-24.
//

import Foundation
import UIKit
class Alert{
    func popup(){
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}
