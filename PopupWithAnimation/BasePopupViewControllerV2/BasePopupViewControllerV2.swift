//
//  PopupViewController.swift
//  PopupWithAnimation
//
//  Created by Aditya on 06/12/24.
//

import UIKit

import UIKit

/// A base view controller class for presenting a popup with a dimmed background and smooth animations.
/// Subclass this to create custom popups by adding content to the `popupView`.
class BasePopupViewControllerV2: UIViewController {
    
    /// The view that represents the popup content.
    /// Subclasses can customize this view to display desired content.
    var popupView: UIView?
    
    // MARK: - Initializers
    
    /// Initializes the popup view controller with default modal presentation and transition styles.
    init() {
        super.init(nibName: nil, bundle: nil)
        // Present the view controller over the full screen with a cross-dissolve animation.
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    /// This initializer is required for subclassing but is not implemented as it is not needed.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    /// Called before the view appears. Animates the popup presentation.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animatePopupPresentation()
    }
    
    /// Called after the view has been loaded. Sets up the UI and dismiss action.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - UI Setup
    
    /// Configures the UI for the popup view controller.
    /// - Sets the background to fully transparent initially.
    /// - Ensures `popupView` is initialized and added to the view hierarchy.
    /// - Adds a tap gesture recognizer for dismissing the popup.
    private func setupUI() {
        // Set the initial background color to transparent.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        // Ensure `popupView` is initialized and add it to the view.
        popupView = popupView ?? UIView()
        popupView?.backgroundColor = .white // Default background color.
        self.view.addSubview(popupView!)
        
        // Setup tap gesture to handle background taps.
        self.setupDismissAction()
    }
    
    // MARK: - Dismiss Gesture
    
    /// Adds a tap gesture recognizer to the view for dismissing the popup.
    /// Taps on the popup view itself will not trigger the dismissal.
    private func setupDismissAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        // Allow touches on popupView to propagate (preventing dismissal).
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    /// Handles taps on the view's background. Dismisses the popup if the tap is outside the popup view.
    /// - Parameter gesture: The tap gesture recognizer.
    @objc private func handleBackgroundTap(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: self.view)
        // Check if the tap is outside the `popupView` and dismiss if true.
        if let popupView = popupView, !popupView.frame.contains(touchLocation) {
            self.animatePopupDismissal()
        }
    }
    
    // MARK: - Animations
    
    /// Animates the popup's presentation by sliding it up and dimming the background.
    private func animatePopupPresentation() {
        // Start the popup view off-screen.
        popupView?.transform = CGAffineTransform(translationX: 0, y: popupView?.bounds.height ?? 0)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            // Dim the background and bring the popup into view.
            self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self?.popupView?.transform = .identity
        })
    }
    
    /// Animates the popup's dismissal by sliding it down and clearing the background dimming.
    private func animatePopupDismissal() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            // Clear the background dimming and slide the popup off-screen.
            self?.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self?.popupView?.transform = CGAffineTransform(translationX: 0, y: self?.popupView?.bounds.height ?? 0)
        }, completion: { [weak self] _ in
            // Dismiss the view controller after the animation completes.
            self?.dismiss(animated: false, completion: nil)
        })
    }
}
