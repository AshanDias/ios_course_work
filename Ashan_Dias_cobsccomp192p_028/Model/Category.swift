//
//  Category.swift
//  Ashan_Dias_cobsccomp192p_028
//
//  Created by Ashan Dias on 2021-04-11.
//

import Foundation

struct Category{
    var name:String!
    var id:String!
    func getJSON() -> NSMutableDictionary {
           let dict = NSMutableDictionary()
           dict.setValue(name, forKey: "name")
            dict.setValue(id, forKey: "id")
           return dict
       }
}
