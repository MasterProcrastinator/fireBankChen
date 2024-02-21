//
//  ViewController.swift
//  fireBankChen
//
//  Created by ALVIN CHEN on 2/15/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
class ViewController: UIViewController {

    var ref: DatabaseReference!
    static var UsedNames = [String]()
    static var Name = ""
    static var Pass = ""
    static var mon = 0.0
    @IBOutlet weak var nameTextViewOutlet: UITextField!
    
    @IBOutlet weak var passwordViewOutlet: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        ViewController.Name = ""
        ViewController.Pass = ""
        ViewController.mon = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        ref.child("accounts").observe(.childAdded, with: {(snapshot) in
            
            let n = snapshot.value as! [String : Any]
            
            var b = Bank(dict: n)
            b.key = snapshot.key
            var checker = false
            for notAvailable in ViewController.UsedNames{
                if b.name == notAvailable{
                    checker = true
                }
                else{
                    checker = false
                }
            }
            if(checker == false){
                ViewController.Name = "\(b.name)"
                ViewController.Pass = "\(b.password)"
                ViewController.mon = 0.0
                ViewController.UsedNames.append(b.name)
            }
            else{
                //have some popup say name taken and delete from fire base this object
                b.deleteFromFirebase()
            }

            
            
        })
        
        
    }

    
    @IBAction func signAction(_ sender: UIButton) {
        var bankAccount = Bank(name: nameTextViewOutlet.text!, password: passwordViewOutlet.text!, money: 0)
        bankAccount.saveToFireBase()
        
        performSegue(withIdentifier: "segue", sender: nil)
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        
        performSegue(withIdentifier: "segue", sender: nil)
        
        
    }
    
}

