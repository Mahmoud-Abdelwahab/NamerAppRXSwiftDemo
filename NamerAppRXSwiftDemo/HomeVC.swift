//
//  HomeVC.swift
//  NamerAppRXSwiftDemo
//
//  Created by Asis on 3/20/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {
    
    @IBOutlet weak var helloLable: UILabel!
    @IBOutlet weak var namesLable: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    let disposeBag = DisposeBag()
    
    let namesList = BehaviorRelay<[String]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindHelloLableWithTextField()
        bindButtonWithNamesLable()
        bindArrayListWithNamesLable()
    }

    func bindHelloLableWithTextField(){
        nameTF.rx.text.orEmpty
            .map({  self.submitBtn.isEnabled = !$0.isEmpty ? true:false
                return "Hello, " + $0
            })
            .bind(to: helloLable.rx.text).disposed(by: disposeBag)
            
    }

    func bindButtonWithNamesLable(){
        submitBtn.rx.tap
            .debounce(RxTimeInterval.milliseconds(60), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
               
                self.namesList.accept(self.namesList.value + [self.nameTF.text ?? ""]) // this is how to append element to behavior relay of type array
                self.namesLable.rx.text.onNext(self.namesList.value.joined(separator: ", "))
                self.nameTF.rx.text.onNext("")
                self.helloLable.rx.text.onNext("Type Your Name")
                self.submitBtn.isEnabled = self.nameTF.text?.isEmpty ?? false ? false:true
            }).disposed(by: disposeBag)
    }
    
    func bindArrayListWithNamesLable(){
        self.namesLable.rx.text.onNext(self.namesList.value.joined(separator: ", "))
    }
    
}

