//
//  ViewController.swift
//  PopupWithAnimation
//
//  Created by Aditya on 06/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
    }
    
    @IBAction private func didTapShowPopup() {
        self.showPopup()
    }
    
    
    private func showPopup() {
        let popupData = PopupData(height: 300)
        let popupVC = PopupViewController(popupData: popupData)
        self.present(popupVC, animated: false)
    }

}

