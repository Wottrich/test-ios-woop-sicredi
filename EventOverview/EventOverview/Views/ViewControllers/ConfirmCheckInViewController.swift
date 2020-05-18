//
//  ConfirmCheckInViewController.swift
//  EventOverview
//
//  Created by Wottrich on 18/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

protocol ConfirmCheckInViewControllerProtocol {
    func confirmCheckIn (name: String, email: String)
}

class ConfirmCheckInViewController: BaseViewController {

    var delegate: ConfirmCheckInViewControllerProtocol?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.text = "Lucas"
        self.emailTextField.text = "123@gmail.com"
    }

    @IBAction func didTapConfirm(_ sender: Any) {
        
        if let name = self.nameTextField.text, let email = self.emailTextField.text,
            !name.isEmpty && !email.isEmpty {
            self.dismiss(animated: true, completion: {
                self.delegate?.confirmCheckIn(name: name, email: email)
            })
        } else {
            self.alert(error: "Verifique se você preencheu todos os campos.")
        }
        
    }
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
