//
//  PopupViewController.swift
//  PopupWithAnimation
//
//  Created by Aditya on 06/12/24.
//

import UIKit

struct PopupData {
    var height: CGFloat
    var bgColor: UIColor?
}

final class PopupViewController: UIViewController {
    
    let popupData: PopupData
    
    lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = popupData.bgColor ?? .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(popupData: PopupData) {
        self.popupData = popupData
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animatePopupPresentation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0) // Start fully transparent
        self.view.addSubview(popupView)
        self.setupPopupBgConstraints()
        self.setupDismissAction()
    }
    
    private func setupPopupBgConstraints() {
        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            popupView.heightAnchor.constraint(equalToConstant: popupData.height)
        ])
    }
    
    private func setupDismissAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDismissView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapDismissView() {
        self.animatePopupDismissal()
    }
    
    private func animatePopupPresentation() {
        popupView.transform = CGAffineTransform(translationX: 0, y: popupData.height)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.popupView.transform = .identity
        })
    }
    
    private func animatePopupDismissal() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.popupView.transform = CGAffineTransform(translationX: 0, y: self.popupData.height)
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
}
