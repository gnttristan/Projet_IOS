//
//  ViewController.swift
//  Projet IOS
//
//  Created by Tristan GINET on 1/16/24.
//

import UIKit


extension Int {
    func formattedSize() -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = .useAll
        formatter.countStyle = .file
        formatter.includesUnit = true
        formatter.isAdaptive = true

        return formatter.string(fromByteCount: Int64(self))
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

