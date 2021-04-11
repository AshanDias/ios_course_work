//
//  MenuItem.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-11.
//

import Foundation
import UIKit
struct MenuItem{
    var name:String
    var desc:String
    var price:Double
    var img:String
    var category:String
    var discount:Int
    var sellType:Bool
    var image:UIImage!
    func getJSON() -> NSMutableDictionary {
           let dict = NSMutableDictionary()
           dict.setValue(name, forKey: "name")
            dict.setValue(desc, forKey: "desc")
            dict.setValue(price, forKey: "price")
            dict.setValue(img, forKey: "img")
            dict.setValue(category, forKey: "category")
            dict.setValue(discount, forKey: "discount")
            dict.setValue(sellType, forKey: "sellTypes")
           return dict
       }
}
