//
//  AddNewNameVC.swift
//  NamerAppRXSwiftDemo
//
//  Created by Asis on 3/20/21.
//

import UIKit
import RxSwift
import RxCocoa

class AddNewNameVC: UIViewController {

    @IBOutlet weak var newNameTF: UITextField!
    @IBOutlet weak var addNewNameBtn: UIButton!
    let disposeBag = DisposeBag()
    
    let nameSubject = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAddNewNameBtn()
    }
   
    func bindAddNewNameBtn(){
        addNewNameBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else{return}
                if !(self.newNameTF.text!.isEmpty){
                    self.nameSubject.onNext(self.newNameTF.text!)
                    self.dismiss(animated: true, completion: nil)
                }
            }).disposed(by: disposeBag)
    }
}
