//
//  AlertPopup.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-24.
//

import Foundation
import UIKit
class AlertPopupData{
    let context:UIViewController
    init(_ context:UIViewController) {
        self.context = context
    }
    //a utility function to show a popup with message
    func infoPop(title:String,body:String){
        let alert = UIAlertController(title: title, message:body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        context.present(alert,animated: true)
    }
}
