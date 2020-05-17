//
//  ViewController.swift
//  EventOverview
//
//  Created by Wottrich on 16/05/20.
//  Copyright © 2020 Wottrich Technology Company. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func alert(title: String = "Atenção", error message: String,
               button: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }

}

