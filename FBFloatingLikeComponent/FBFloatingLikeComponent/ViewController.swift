//
//  ViewController.swift
//  FBFloatingLikeComponent
//
//  Created by Hosamane, Vinay K N on 17/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constants {
        static let reactionButtonWidth: CGFloat = 50.0
        static let reactionButtonHeight: CGFloat = 50.0
        static let reactionViewButtonSpacing: CGFloat = 10.0
    }
    
    var reactionButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "blue_like"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var reactionContainerBottomConstraint: NSLayoutConstraint!
    
//    var reactionStackView: UIStackView = {
//        //first view
//        var subViews = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "surprised"),#imageLiteral(resourceName: "angry"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "cry")].map { image -> UIView in
//            var imageView = UIImageView(image: image)
//            return imageView
//        }
//
//        // let's add stackview
//        let stackView = UIStackView(arrangedSubviews: subViews)
//        stackView.distribution = .fillEqually
//        //stackView.axis = .horizontal
//        return stackView
//    }()
    
    var reactionView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        //let's add corner radius
        containerView.layer.cornerRadius = 25.0
        
        // let's add some shadow
        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        let subViews = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "surprised"),#imageLiteral(resourceName: "angry"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "cry")].map { image -> UIView in
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }

        // let's add stackview
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //stackView.axis = .horizontal

        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
        
        return containerView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add background image
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "fb_core_data_bg"))
//        imageView.contentMode = .scaleAspectFill
//        imageView.frame = view.bounds
//
//        view.insertSubview(imageView, at: 0)
        
        view.addSubview(reactionButton)
        
        // add constrainnts
        NSLayoutConstraint.activate([
            reactionButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            reactionButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            reactionButton.widthAnchor.constraint(equalToConstant: Constants.reactionButtonWidth),
            reactionButton.heightAnchor.constraint(equalToConstant: Constants.reactionButtonHeight)
        ])
        
        // long tap gesture to button
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressedButton(recogniser:)))
        gesture.minimumPressDuration = 0.5
        gesture.delegate = self
        
        // add this gesture to button
        reactionButton.addGestureRecognizer(gesture)
        
        view.addSubview(reactionView)
        
        reactionContainerBottomConstraint =  reactionView.bottomAnchor.constraint(equalTo: reactionButton.topAnchor, constant: 30)
        
        NSLayoutConstraint.activate([
            reactionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            reactionContainerBottomConstraint,
            reactionView.widthAnchor.constraint(equalToConstant: 200),
            reactionView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        reactionView.alpha = 0.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc
    func longPressedButton(recogniser: UILongPressGestureRecognizer) {
        view.addSubview(reactionView)
        
        if reactionContainerBottomConstraint != nil {
            NSLayoutConstraint.deactivate([reactionContainerBottomConstraint])

            reactionContainerBottomConstraint =  reactionView.bottomAnchor.constraint(equalTo: reactionButton.topAnchor, constant: -10)

            NSLayoutConstraint.activate([
                reactionContainerBottomConstraint
            ])

        } else {
            NSLayoutConstraint.activate([reactionContainerBottomConstraint])
        }
        
        reactionView.updateConstraintsIfNeeded()
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.3,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            self.reactionView.alpha = 1.0
            self.view.layoutIfNeeded()
        }

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
