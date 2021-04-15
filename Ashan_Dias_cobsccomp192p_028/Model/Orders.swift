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
    var tel:Int!
    var date:String!
    var longtude:Double!
    var latitude:Double!
    func getJSON() -> NSMutableDictionary {
           let dict = NSMutableDictionary()
           dict.setValue(unit, forKey: "unit")
            dict.setValue(price, forKey: "price")
            dict.setValue(name, forKey: "name")
            dict.setValue(cusName, forKey: "cusName")
            dict.setValue(ord_id, forKey: "ord_id")
            dict.setValue(status, forKey: "status")
            dict.setValue(randNo, forKey: "randNo")
            dict.setValue(tel, forKey: "tel")
            dict.setValue(date, forKey: "date")
            dict.setValue(longtude, forKey: "longtude")
            dict.setValue(latitude, forKey: "latitude")
           return dict
       }
}

struct GroupOrders{
    var status:Int
    var orders:[OrderDetails]
}
