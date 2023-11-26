//
//  NotificationBellView.swift
//  TestRigForShakeyBell
//
//  Created by Diego Sierra on 23/11/23.
//

import UIKit


class NotificationBellView: UIView {
    let imageView = UIImageView()
    
    var duration: Double = 1 {
        didSet {
            shakeWith(duration: duration, angle: angle, yOffset: yOffset)
        }
    }
    
    //    To convert degrees to radians you multiply the radians by pi/180
    var angle: CGFloat = 22.5 * (.pi/180) {
        didSet {
            shakeWith(duration: duration, angle: angle, yOffset: yOffset)
        }
    }
    
    var yOffset: CGFloat = 0.5 {
        didSet {
            shakeWith(duration: duration, angle: angle, yOffset: yOffset)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

extension NotificationBellView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "bell.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        imageView.image = image
    }
    
    func layout() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 128),
            imageView.widthAnchor.constraint(equalToConstant: 128)
        ])
        
    }
    
    func setup() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_ :)))
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
        
        
    }
}

// MARK: Actions

extension NotificationBellView {
    @objc func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
        shakeWith(duration: duration, angle: angle, yOffset: yOffset)
    }
    
    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        
        
        let numberOfFrames: Double = 6
        let frameDuration = Double(1/numberOfFrames)
        
        //        The view's horizontal anchor point shall not be changed, only the vertical anchor point will be different.
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        print("anchorPoint: \(imageView.layer.anchorPoint)")
        
        UIView.animateKeyframes(withDuration: duration, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
             
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*2, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*3, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*4, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*5, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform.identity
            }
        }
    }
    
}

// https://www.hackingwithswift.com/example-code/calayer/how-to-change-a-views-anchor-point-without-moving-it

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        //        This function is basically resetting the position and anchor point so that you're only setting the anchor point.
        //        Let the compiler know where the view's anchor point used to be at the beginning and where the new one is gonna be placed according to the 'point' parametre.
        //        (I suppose) Multiplying the bounds' width by the x point and height by the y point is used to obtain the new/old centre of the view's position (0.5 [In the case of a UIslider that modifies a view's anchor point], * 140 = 70 (a.k.a you're halving the number, a.k.a position the view's position in the middle)
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        
        //        Don't know what the .applying(transform) is used for, though; if you eliminate these two lines of code, the animation is not affected.
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        //   Making sure that the entire view doesn't move throughout the canvas, but only the anchor point in the y axis, for the animation to occur. (I suppose) summing the position according to the new point and subtracting the old point will let know the compiler that the position of the view itself doesn't change throughout the canvas and that the anchor point is the only thing that is moved (in other words, you're basically saying, this is the new centre of the UIImage, whose position in the canvas shall not be changed; you're returning the view to its previous position point and then updating it with the new one).
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
        
    }
}
