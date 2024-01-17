//
//  DocumentViewController.swift
//  Projet IOS
//
//  Created by Tristan GINET on 1/17/24.
//

import Foundation

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName {
            ImageView.image = UIImage(named: imageName)
        }
    }
}


