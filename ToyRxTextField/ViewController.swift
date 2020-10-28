//
//  ViewController.swift
//  ToyRxTextField
//
//  Created by Faiz Mokhtar AD0502 on 28/10/2020.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var dummyLabel: UILabel!
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    func setupBinding() {
        let textInput = firstTextField.rx.text
            .observeOn(MainScheduler.instance)
        
        textInput.bind(to: dummyLabel.rx.text)
            .disposed(by: bag)
    }
}

