//
//  ViewController.swift
//  TestRigForShakeyBell
//
//  Created by Diego Sierra on 22/11/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var durationSlider: UISlider!
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var offsetSlider: UISlider!
    
    let bellView = NotificationBellView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       setup()
    }

    private func setup() {
        bellView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.insertArrangedSubview(bellView, at: 0)
        
        NSLayoutConstraint.activate([
            bellView.heightAnchor.constraint(equalToConstant: 128),
            bellView.widthAnchor.constraint(equalToConstant: 128)
        ])
    }
    
    @IBAction func durationChanged(_ sender: UISlider) {
        bellView.duration = Double(sender.value)*2
       
    }
    
    
    @IBAction func angleChanged(_ sender: UISlider) {
        let normalized = CGFloat(sender.value) * .pi/2
        bellView.angle = normalized
        
    }
    
    @IBAction func offsetChanged(_ sender: UISlider) {
        bellView.yOffset = CGFloat(sender.value)
    }
    
    
    @IBAction func reset(_ sender: Any) {
        durationSlider.value = 0.5
        angleSlider.value = 0.5
        offsetSlider.value = 0.5
        
        bellView.duration = Double(1)
        bellView.angle = 22.5 * (.pi/180)
        bellView.yOffset = 0.5
    }
    
    
}

