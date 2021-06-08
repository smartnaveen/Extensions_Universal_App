//
//  ViewController.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 11/03/21.
//

import UIKit
import OTPFieldView

class ViewController: UIViewController {
    

    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    
    // MARK: - App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        otpTextFieldView.backgroundColor = .clear
        self.view.backgroundColor = UIColor.init(105, 60, 114)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupOtpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

        
}

extension ViewController {
    
    func setupOtpView(){
            self.otpTextFieldView.fieldsCount = 12
            self.otpTextFieldView.fieldBorderWidth = 2
            self.otpTextFieldView.defaultBorderColor = UIColor.black
            self.otpTextFieldView.filledBorderColor = UIColor.green
            self.otpTextFieldView.cursorColor = UIColor.red
            self.otpTextFieldView.displayType = .underlinedBottom
            self.otpTextFieldView.fieldSize = 40
            self.otpTextFieldView.separatorSpace = 10
            self.otpTextFieldView.shouldAllowIntermediateEditing = false
           // self.otpTextFieldView.delegate = self
            self.otpTextFieldView.initializeUI()
        }
}
