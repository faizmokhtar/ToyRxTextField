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

    @IBOutlet var firstTextField: UITextField! {
        didSet {
            firstTextField.keyboardType = .phonePad
        }
    }
    @IBOutlet var dummyLabel: UILabel!
    @IBOutlet var updateTextFieldButton: UIButton!
    
    let firstText: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    func setupUI() {
        firstTextField.becomeFirstResponder()
    }

    func setupBinding() {
        
        firstTextField.rx.text.orEmpty
            .bind(to: firstText)
            .disposed(by: bag)
        
        firstTextField.rx.controlEvent(.editingChanged)
            .asObservable()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
        
        firstTextField.rx.text.orEmpty
            .debug()
            .bind(to: firstText)
            .disposed(by: bag)
    
        firstText
            .bind(to: dummyLabel.rx.text)
            .disposed(by: bag)
        
        firstText
            .debug()
            .bind(to: firstTextField.rx.text)
            .disposed(by: bag)
        
        updateTextFieldButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.firstText.accept(self.prefix("1320202030"))
            })
            .disposed(by: bag)
    }
    
    func prefix(_ text: String) -> String {
        return "+60\(text)"
    }
}

