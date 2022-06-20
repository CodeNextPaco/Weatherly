//
//  ViewController.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    var animationView : AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        //TESTING LOTTIE
        animationView = .init(name: "thunder")
        animationView?.loopMode = .loop
        animationView?.frame = self.view.bounds
        view.insertSubview(animationView!, at: 0)
        animationView?.animationSpeed = 0.8
        animationView?.play()
        
        
     
        
        
    }
   
    @IBAction func searchForLocation(_ sender: Any) {
        
        
        if(self.searchField.text !=
           ""){
            print("Search for location:")
            
            let locationToSearch = self.searchField.text
            
            print(locationToSearch!)
            
        } else {
            
            print("Enter a location")
        }
    }
    
}

