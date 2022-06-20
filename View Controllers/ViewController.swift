//
//  ViewController.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    var animationView : AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TESTING LOTTIE
        animationView = .init(name: "thunder")
        animationView?.loopMode = .loop
        animationView?.frame = self.view.bounds
        view.addSubview(animationView!)
        animationView?.animationSpeed = 0.8
        animationView?.play()
        
        
    }


}

