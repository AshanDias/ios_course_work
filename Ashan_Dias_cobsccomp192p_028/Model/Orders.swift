//
//  Orders.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-12.
//

import Foundation


struct  OrderDetails {
    var unit:Int
    var price:Double
    var name:String!
    var cusName:String
    var ord_id:String
    var status:Int!
    var randNo:Int!
    
    func getJSON() -> NSMutableDictionary {
           let dict = NSMutableDictionary()
           dict.setValue(unit, forKey: "unit")
            dict.setValue(price, forKey: "price")
            dict.setValue(name, forKey: "name")
            dict.setValue(cusName, forKey: "cusName")
            dict.setValue(ord_id, forKey: "ord_id")
            dict.setValue(status, forKey: "status")
            dict.setValue(randNo, forKey: "randNo")
           return dict
       }
}

struct GroupOrders{
    var status:Int
    var orders:[OrderDetails]
}