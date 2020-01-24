//
//  ViewController.swift
//  DataTransfer
//
//  Created by Marni Anuradha on 11/11/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//

import UIKit
import Toast_Swift

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTF: UITextField!
    
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var ageTF: UITextField!
    
    @IBOutlet weak var qualificationTF: UITextField!
    override func viewDidLoad() {
        firstNameTF.clearButtonMode = .always
        firstNameTF.delegate = self
        
        lastNameTF.clearButtonMode = .always
        lastNameTF.delegate = self
        
        ageTF.clearButtonMode = .always
        ageTF.delegate = self
        
        qualificationTF.clearButtonMode = .always
        qualificationTF.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var returnVal:Bool = false
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if(textField == firstNameTF)
        {
            returnVal = true
        }else if(textField == lastNameTF)
        {
            if(firstNameTF.text!.count>=2)
            {
                returnVal = true
            }else
            {
                returnVal = false
            }
        }else if(textField == ageTF)
        {
            if(firstNameTF.text!.count>=2 &&
                lastNameTF.text!.count>=2 )
            {
                returnVal = true
            }else
            {
                returnVal = false
            }
}
        else if(textField == qualificationTF)
        {
            if(firstNameTF.text!.count>=2 && lastNameTF.text!.count>=2 &&
                Int(ageTF.text!)! < 120)
            {
                returnVal = true
            }else
            {
                returnVal = false
            }
}
return returnVal
}
    
    // DID BEGIN EDITING
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.backgroundColor = UIColor.white
    }
    
    
    //SHOULD CLEAR
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true
    }
    
    // SHOULD RETURN
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        //textField.backgroundColor=UIColor.yellow
        
        if(textField==firstNameTF)
        {
            returnVal = isValidForAlphabets(alphabets: textField.text!)
        }
        
        if(textField==lastNameTF)
        {
            returnVal = isValidForAlphabets(alphabets: textField.text!)
        }
        
        if(textField==ageTF)
        {
            returnVal = isValidForNumbers(numbers: textField.text!)
        }
        
        if(textField==qualificationTF)
        {
            returnVal = isValidForAlphabets(alphabets: textField.text!)
        }
        
        
        return returnVal
    }
    
    
    // FIRSTNAME , LASTNAME , QUALIFICATION
    
    func isValidForAlphabets(alphabets:String) -> Bool {
        let RegEx = "[A-Za-z ]{2,25}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: alphabets)
    }
    
    
    //  AGE
    
    func isValidForNumbers(numbers:String) -> Bool {
        let RegEx = "[0-9 ]{2,10}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: numbers)
    }
    
    //SHOULD CHANGE CHARACTER
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        
    {
        
        if(textField==firstNameTF || textField==lastNameTF || textField==qualificationTF)
            
        {
            var  allowableCharacter=CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")
            if(string.rangeOfCharacter(from: allowableCharacter) != nil || string=="")
            {
                return true
                
            }else{
                
                self.view.makeToast("Enter Only Alphabets", duration: 3.0, position: .center)
                
            }
            
        }
        if(textField==ageTF)
            
        {
            var  allowableCharacter=CharacterSet(charactersIn: "0123456789 ")
            
            if(string.rangeOfCharacter(from: allowableCharacter) != nil || string=="")
                
            {
                return true
                
            }else{
                
                self.view.makeToast("Enter Only Numbers", duration: 3.0, position: .center)
                
            }
            
        }
        
        return true
        
    }
    
    @IBAction func onNextBtnTap(_ sender: UIButton) {
        
        if((firstNameTF.text?.isEmpty)! || (lastNameTF.text?.isEmpty)! || (ageTF.text?.isEmpty)! || (qualificationTF.text?.isEmpty)!)
        {
            ac(title: "Alert", messageDetails: "Enter all fields")
        }else
        {
            var secondVC = storyboard?.instantiateViewController(withIdentifier: "interVC") as!
            InterViewController
            
            present(secondVC, animated: true, completion: nil)
        }
    }
        func ac(title:String, messageDetails:String)
        {
            var nextButton = UIAlertController(title: "Alert", message: "", preferredStyle: UIAlertController.Style.alert)
            
            present(nextButton, animated: true, completion: nil)
            var successAction=UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            
            nextButton.addAction(successAction)
        }
    
}
