//
//  Bank.swift
//  fireBankChen
//
//  Created by ALVIN CHEN on 2/15/24.
//

import FirebaseDatabase
import FirebaseCore
import Foundation

class Bank{
    
    var name : String
    var password : String
    var money: Double
    var key = ""
    var ref = Database.database().reference()
    
    init(name: String, password: String, money: Double){
        self.name = name
        self.password = password
        self.money = money
    }
    
    init(dict:[String:Any]){
       
            if let n = dict["name"] as? String{
                name = n
            }
            else{
                name = ""
            }
        
    
            if let p = dict["password"] as? String{
                password = p
            }
            else{
            password = ""
            }
        
            if let m = dict["money"] as? Double{
            money = m
            }
            else{
            money = 0.0
            }
        
        }
    
    
    func saveToFireBase(){
        let dict = ["name" : name,"password" : password,"money" : money] as [String : Any]
        ref.child("accounts").childByAutoId().setValue(dict)
        
        
        key = ref.child("accounts").childByAutoId().key ?? "0"
        
    }
    func deleteFromFirebase(){
        ref.child("accounts").child(key).removeValue()
}
    
    
    
    
    
    
}
