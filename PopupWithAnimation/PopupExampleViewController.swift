//
//  PopupExampleViewController.swift
//  PopupWithAnimation
//
//  Created by Aditya on 06/12/24.
//

import UIKit

class PopupExampleViewController: BasePopupViewControllerV2 {
    
    @IBOutlet weak var popupBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popupView = popupBgView
    }
}
