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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
}
